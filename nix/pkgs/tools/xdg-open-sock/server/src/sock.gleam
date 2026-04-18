import gleam/io
import gleam/bit_array
import gleam/erlang/process
import gleam/otp/actor
import gleam/result
import simplifile

type ErlangTcpOption

type TcpOption {
  Local
  Binary
  ZeroPacketHeader
  UdsPath(String)
  ActiveModePassive
  ReuseAddr
}

type ListenSocket

type Socket

type SocketReason

@external(erlang, "gen_tcp", "listen")
fn listen_tcp(
  port: Int,
  options: List(ErlangTcpOption),
) -> Result(ListenSocket, SocketReason)

@external(erlang, "socket_ffi", "to_erl_tcp_options")
fn to_erl_tcp_options(opts: List(TcpOption)) -> List(ErlangTcpOption)

@external(erlang, "gen_tcp", "accept")
fn accept_tcp(lsock: ListenSocket) -> Result(Socket, Nil)

@external(erlang, "gen_tcp", "recv")
fn recv_tcp(sock: Socket, length: Int, timeout: Int) -> Result(BitArray, Nil)

@external(erlang, "socket_ffi", "close")
fn close_tcp(sock: Socket) -> Result(Nil, Nil)

fn serve(lsock: ListenSocket, handler: fn(String) -> Nil) {
  case accept_tcp(lsock) {
    Ok(sock) -> {
      let _ = handle_client(sock, handler)
      serve(lsock, handler)
    }
    Error(_) -> {
      serve(lsock, handler)
    }
  }
}

fn handle_client(sock: Socket, handler: fn(String) -> Nil) {
  use data <- result.try(recv_tcp(sock, 0, 5000))
  use url <- result.try(bit_array.to_string(data))

  handler(url)

  close_tcp(sock)
}

pub type Message {
  Shutdown
}

pub type State {
  State(socket_path: String)
}

pub fn new(
  name: process.Name(Message),
  socket_path: String,
  handler: fn(String) -> Nil,
) -> Result(actor.Started(process.Subject(Message)), actor.StartError) {
  let opts =
    [
      UdsPath(socket_path),
      Local,
      Binary,
      ZeroPacketHeader,
      ActiveModePassive,
      ReuseAddr,
    ]
    |> to_erl_tcp_options

  let _ = delete_sock(socket_path)

  case listen_tcp(0, opts) {
    Ok(lsock) -> {
      io.println("Listening on " <> socket_path)

      let _ = process.spawn(fn() { serve(lsock, handler) })

      actor.new(State(socket_path:))
      |> actor.named(name)
      |> actor.on_message(message_handler)
      |> actor.start()
    }
    Error(_) -> {
      io.print_error("Failed to listen")

      Error(actor.InitFailed("failed to listen"))
    }
  }
}

fn delete_sock(socket_path: String) -> Result(Nil, simplifile.FileError) {
  use _ <- result.try(simplifile.file_info(socket_path))

  simplifile.delete(socket_path)
  }

fn message_handler(state: State, message: Message) -> actor.Next(State, Message) {
  case message {
    Shutdown -> {
      let _ = delete_sock(state.socket_path)
      actor.stop()
    }
  }
}

pub fn shutdown(sub: process.Subject(Message)) -> Result(Nil, Nil) {
  process.send(sub, Shutdown)

  Ok(Nil)
}
