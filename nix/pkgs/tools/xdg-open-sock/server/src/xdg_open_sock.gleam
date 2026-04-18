import argv
import clip
import clip/help
import clip/opt
import dispatcher
import gleam/erlang/process
import gleam/io
import gleam/otp/static_supervisor as supervisor
import gleam/otp/supervision
import sock

type Args {
  Args(socket_path: String, open_command: String)
}

fn defer(cleanup, body) {
  body()
  cleanup()
}

fn run(args: Args) -> Nil {
  let dispatcher = process.new_name("dispatcher")
  let socket = process.new_name("socket")

  let dispatcher_supervision =
    fn() { dispatcher.new(dispatcher, args.open_command) }
    |> supervision.worker()

  let socket_supervision =
    fn() {
      sock.new(socket, args.socket_path, fn(url: String) -> Nil {
        io.println("Opening: " <> url)

        let _ = process.named_subject(dispatcher) |> dispatcher.open(url)

        Nil
      })
    }
    |> supervision.worker()

  let assert Ok(_) =
    supervisor.new(supervisor.OneForOne)
    |> supervisor.add(dispatcher_supervision)
    |> supervisor.add(socket_supervision)
    |> supervisor.start()

  use <- defer(fn() {
    let _ =
      process.named_subject(dispatcher)
      |> dispatcher.shutdown()

    let _ =
      process.named_subject(socket)
      |> sock.shutdown()

    Nil
  })

  process.sleep_forever()
}

fn command() -> clip.Command(Args) {
  clip.command({
    use socket_path <- clip.parameter
    use open_command <- clip.parameter

    Args(socket_path:, open_command:)
  })
  |> clip.opt(
    opt.new("socket-path")
    |> opt.help("Socket path")
    |> opt.default("/tmp/xdg-open.sock"),
  )
  |> clip.opt(
    opt.new("open-command")
    |> opt.help("open command")
    |> opt.default("open"),
  )
}

pub fn main() -> Nil {
  let parse_result =
    command()
    |> clip.help(help.simple("xdg-open-sock", "xdg-open socket server"))
    |> clip.run(argv.load().arguments)

  case parse_result {
    Error(e) -> io.println_error(e)
    Ok(args) -> args |> run()
  }
}
