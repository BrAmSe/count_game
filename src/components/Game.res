// //////////////////////////////////////////////////////////
// TYPE DEFINITION
// //////////////////////////////////////////////////////////
let gameStatuses = {
  "new": "new",
  "lost": "lost",
  "won": "won",
  "playing": "playing"
}

type state = {
  gameStatus: string,
  initialSeconds: int,
  accum: int,
}

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
@react.component
let make = (~iSeconds, ~challengeSize, ~challengeRange, ~answerSize) => {
  // //////////////////////////////////////////////////////////
  // STATE
  // /////////////////////////////////////////////////////////
  let (gameStatus, setGameStatus) = React.useState(() => gameStatuses["new"])
  let (accum, setAccum) = React.useState(() => 0)
  let (challengeOptions, setChallengeOptions) = React.useState(() => list{})
  let (targetValue, setTargetValue) = React.useState(() => 0)

  // //////////////////////////////////////////////////////////
  // FUNCTIONS
  // /////////////////////////////////////////////////////////
  let generateOptions =
      (challengeSize, challengeRange) => {
    let (minValue, maxValue) = challengeRange
    Utils.randomListOfSize(minValue, maxValue, challengeSize)
  }

  let selectOption = (targetValue, value) => {
    if (accum + value > targetValue) {
      setGameStatus(_ => gameStatuses["lost"])
    } else if (accum + value == targetValue) {
      setGameStatus(_ => gameStatuses["won"])
    }
    setAccum(prev => prev + value)
  }

  let deselectOption = value => setAccum(prev => prev - value)

  let generateTargetValue = (challengeOptions, answerSize) => {
    switch(Utils.listSample(challengeOptions, answerSize)) {
      | None => failwith("This should never happen")
      | Some(randomNumberList) =>  Utils.sum(randomNumberList)
    }
  }

  let generateChallenge = () => {
    let challengeOptions = generateOptions(challengeSize, challengeRange)
    let targetValue = generateTargetValue(challengeOptions, answerSize)
    setChallengeOptions(_ => challengeOptions)
    setTargetValue(_ => targetValue)
  };

  // //////////////////////////////////////////////////////////
  // EFFECTS
  // /////////////////////////////////////////////////////////
  React.useEffect3(
    () => {
      generateChallenge()
      None
    },
    (challengeSize, challengeRange, answerSize),
  );

  // //////////////////////////////////////////////////////////
  // EVENTS
  // /////////////////////////////////////////////////////////
  let onClickPlayAgain = () => {
    setGameStatus(_ => gameStatuses["new"])
  };

  let onGameStart = () => {
    generateChallenge()
    setAccum(_ => 0)
    setGameStatus(_ => gameStatuses["playing"])
  };

  let onGameReset = () => {
    setGameStatus(_ => gameStatuses["new"])
  };

  let onTimeUp = () => {
    setGameStatus(_ => gameStatuses["lost"])
  };

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  let renderChallengeOptions = challengeOptions => {
    List.mapWithIndex(
      challengeOptions,
      (index, challengeOption) => {
        <ChallengeOption
          key={string_of_int(index)}
          value=challengeOption
          disabled={gameStatus != gameStatuses["playing"]}
          selectOption={selectOption(targetValue)}
          deselectOption
        />
      }
    )
  }

  let renderFooter = () => {
    if (gameStatuses["won"] == gameStatus || gameStatuses["lost"] == gameStatus) {
      <div className="col-12 col flex-right">
        <button className="btn" onClick={_evt => onClickPlayAgain()}>
          {React.string("Play Again")}
        </button>
      </div>
    } else {
      <div className="col-12">
        <Timer
          value=iSeconds
          onStart=onGameStart
          onReset=onGameReset
          onFinish=onTimeUp
        />
      </div>
    }
  }

  <section>
    <header className="row align-center flex-center">
      <h3>
        {React.string(
           "Pick numbers that sum to the target in "
           ++ string_of_int(iSeconds)
           ++ " seconds",
         )}
      </h3>
    </header>
    <div className="row flex-center">
      <Target value=targetValue status=gameStatus />
    </div>
    <div className="row col-8 flex-center">
      {React.array(
        List.toArray(renderChallengeOptions(challengeOptions))
      )}
    </div>
    <footer className="row flex-center">
      <div className="col-8">
        {renderFooter()}
      </div>
    </footer>
  </section>
}