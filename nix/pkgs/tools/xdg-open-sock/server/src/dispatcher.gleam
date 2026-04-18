import gleam/erlang/process
import gleam/otp/actor
import shellout

pub type Message {
  Open(url: String)
  Shutdown
}

pub type State {
  State(open_command: String)
}

pub fn new(name: process.Name(Message), open_command: String) {
  actor.new(State(open_command:))
  |> actor.named(name)
  |> actor.on_message(handler)
  |> actor.start()
}

fn handler(state: State, message: Message) -> actor.Next(State, Message) {
  case message {
    Shutdown -> actor.stop()
    Open(url) -> {
      let _ = shellout.command(run: state.open_command, with: [url], in: ".", opt: [])

      actor.continue(state)
    }
  }
}

pub fn open(sub: process.Subject(Message), url: String) -> Result(Nil, Nil) {
  process.send(sub, Open(url))

  Ok(Nil)
}

pub fn shutdown(sub: process.Subject(Message)) -> Result(Nil, Nil) {
  process.send(sub, Shutdown)

  Ok(Nil)
}
