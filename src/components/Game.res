// //////////////////////////////////////////////////////////
// TYPE DEFINITION
// //////////////////////////////////////////////////////////
type state = {
  gameStatus: string,
  initialSeconds: int,
  accum: int,
};

type action =
  | SaveFields;

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
@react.component
let make = (~iSeconds, ~challengeSize, ~challengeRange, ~answerSize) => {
  // //////////////////////////////////////////////////////////
  // STATE
  // /////////////////////////////////////////////////////////
  let (gameStatus, setGameStatus) = React.useState(() => "new");
  let (initialSeconds, setInitialSeconds) = React.useState(() => iSeconds);
  let (accum, setAccum) = React.useState(() => 0);
  let (challengeOptions, setChallengeOptions) = React.useState(() => list{});
  let (targetValue, setTargetValue) = React.useState(() => 0);

  // //////////////////////////////////////////////////////////
  // FUNCTIONS
  // /////////////////////////////////////////////////////////
  let generateOptions =
      (challengeSize: int, challengeRange: (int, int), answerSize: int) => {
    let (minValue, maxValue) = challengeRange;
    let challengeOptions =
      Utils.randomListOfSize(minValue, maxValue, challengeSize);
    switch(Utils.listSample(challengeOptions, answerSize)) {
      | None => failwith("This should never happen")
      | Some(randomNumberList) => (challengeOptions, Utils.sum(randomNumberList))
    }
  };

  let selectOption = (targetValue, value) =>
    if (accum + value > targetValue) {
      setAccum(_ => accum + value);
      setGameStatus(_ => "lost");
    } else if (accum + value == targetValue) {
      setAccum(_ => accum + value);
      setGameStatus(_ => "won");
    } else {
      setAccum(_ => accum + value);
    };

  let deselectOption = value => setAccum(_ => accum - value);

  let generateChallengeOptions = () => {
    let (challengeOptions, targetValue) =
      generateOptions(challengeSize, challengeRange, answerSize);
    setChallengeOptions(_ => challengeOptions);
    setTargetValue(_ => targetValue);
  };

  // //////////////////////////////////////////////////////////
  // EFFECTS
  // /////////////////////////////////////////////////////////
  React.useEffect3(
    () => {
      generateChallengeOptions();
      None;
    },
    (challengeSize, challengeRange, answerSize),
  );

  // //////////////////////////////////////////////////////////
  // EVENTS
  // /////////////////////////////////////////////////////////
  let onClickPlayAgain = () => {
    setGameStatus(_ => "new");
  };

  let onGameStart = () => {
    generateChallengeOptions();
    setAccum(_ => 0);
    setGameStatus(_ => "playing");
  };

  let onGameReset = () => {
    setGameStatus(_ => "new");
  };

  let onTimeUp = () => {
    setGameStatus(_ => "lost");
  };

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  let renderChallengeOptions = challengeOptions => {
    List.mapWithIndex(
      challengeOptions,
      (index, challengeOption) =>
        <ChallengeOption
          key={string_of_int(index)}
          value=challengeOption
          gStatus=gameStatus
          selectOption={selectOption(targetValue)}
          deselectOption
        />
    );
  };

  let renderFooter = () =>
    if (Array.includes(["won", "lost"], gameStatus)) {
      <div className="col-12 col flex-right">
        <button className="btn" onClick={_evt => onClickPlayAgain()}>
          {React.string("Play Again")}
        </button>
      </div>;
    } else {
      <div className="col-12 col">
        <Timer
          value=initialSeconds
          onStart=onGameStart
          onReset=onGameReset
          onFinish=onTimeUp
        />
      </div>;
    };

  <div className="row flex-center">
    <div className="md-8 col">
      <h3>
        {React.string(
           "Pick numbers that sum to the target in "
           ++ string_of_int(initialSeconds)
           ++ " seconds",
         )}
      </h3>
      <div className="row flex-center">
        <Target value=targetValue status=gameStatus />
      </div>
      <div className="row">
        {React.array(
           List.toArray(renderChallengeOptions(challengeOptions)),
         )}
      </div>
      <div className="row"> {renderFooter()} </div>
    </div>
  </div>;
};