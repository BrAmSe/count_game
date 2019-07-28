// //////////////////////////////////////////////////////////
// TYPE DEFINITION
// //////////////////////////////////////////////////////////
type state = {running: bool};

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
[@react.component]
let make = (~value: int, ~onStart, ~onReset, ~onFinish) => {
  // //////////////////////////////////////////////////////////
  // STATE
  // /////////////////////////////////////////////////////////
  let (running, setRunning) = React.useState(() => false);
  let (timeRemaining, setTimeRemaining) = React.useState(() => value);

  // //////////////////////////////////////////////////////////
  // EFFECTS
  // /////////////////////////////////////////////////////////

  // //////////////////////////////////////////////////////////
  // EVENTS
  // /////////////////////////////////////////////////////////
  let onClickStart = () =>
    if (!running) {
      setTimeRemaining(_ => value);
      setRunning(_ => true);
      onStart();
    };

  let onClickReset = () =>
    if (running) {
      setTimeRemaining(_ => value);
      onReset();
    };

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  let renderButton = () =>
    if (!running) {
      <button className="btn btn-success" onClick={_evt => onClickStart()}>
        {React.string("Start")}
      </button>;
    } else {
      <button className="btn btn-primary" onClick={_evt => onClickReset()}>
        {React.string("Reset")}
      </button>;
    };

  <div className="row">
    <div className="col-10 col flex-center">
      <div className="headings">
        {React.string(string_of_int(timeRemaining))}
      </div>
    </div>
    <div className="col-2 col flex-right"> {renderButton()} </div>
  </div>;
};