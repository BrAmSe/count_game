// //////////////////////////////////////////////////////////
// TYPE DEFINITION
// //////////////////////////////////////////////////////////
type state = {
  running: bool,
  timeRemaining: int,
}

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
@react.component
let make = (~value: int, ~onStart, ~onReset, ~onFinish) => {
  // //////////////////////////////////////////////////////////
  // STATE
  // /////////////////////////////////////////////////////////
  let (running, setRunning) = React.useState(() => false)
  let (timeRemaining, setTimeRemaining) = React.useState(() => value)

  // //////////////////////////////////////////////////////////
  // EFFECTS
  // /////////////////////////////////////////////////////////
  React.useEffect1(
    () => {
      let timerId =
        Js.Global.setInterval(
          () => setTimeRemaining(timeRemaining => timeRemaining - 1),
          1000,
        )
      if (!running) {
        Js.Global.clearInterval(timerId)
      }
      Some(() => Js.Global.clearInterval(timerId))
    },
    [running],
  )

  React.useEffect1(
    () => {
      if (timeRemaining <= 0) {
        setRunning(_ => false)
        onFinish()
      }
      None
    },
    [timeRemaining],
  )

  // //////////////////////////////////////////////////////////
  // EVENTS
  // /////////////////////////////////////////////////////////
  let onClickStart = () =>
    if (!running) {
      setRunning(_ => true)
      onStart()
    }

  let onClickReset = () =>
    if (running) {
      setTimeRemaining(_ => value)
      setRunning(_ => false)
      onReset()
    }

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  let renderButton = () => {
    if (!running) {
      <button className="btn btn-success" onClick={_evt => onClickStart()}>
        {React.string("Start")}
      </button>
    } else {
      <button className="btn btn-primary" onClick={_evt => onClickReset()}>
        {React.string("Reset")}
      </button>
    }
  }

  <aside className="row flex-middle">
    <div className="col-10 col flex-center">
      <h3> {React.string(string_of_int(timeRemaining))} </h3>
    </div>
    <div className="col-2 col flex-right"> {renderButton()} </div>
  </aside>
}