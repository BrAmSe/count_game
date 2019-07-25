type state = {
  gameStatus: string,
  initialSeconds: int,
  accum: int,
};

type action =
  | SaveFields;

let generateOptions =
    (challengeSize: int, challengeRange: (int, int), answerSize: int) => {
  let (minValue, maxValue) = challengeRange;
  let challengeOptions =
    Utils.randomListOfSize(minValue, maxValue, challengeSize);
  let targetValue =
    Utils.sum(Utils.arrSample(Array.of_list(challengeOptions), answerSize));
  Js.log(Array.of_list(challengeOptions));
  (challengeOptions, targetValue);
};

[@react.component]
let make = (~iSeconds, ~challengeSize, ~challengeRange, ~answerSize) => {
  let (gameStatus, setGameStatus) = React.useState(() => "new");
  let (initialSeconds, setInitialSeconds) = React.useState(() => iSeconds);
  let (accum, setAccum) = React.useState(() => 0);

  let (challengeOptions, targetValue) =
    generateOptions(challengeSize, challengeRange, answerSize);

  <div className="game">
    <div className="help">
      {React.string(
         "Pick numbers that sum to the target in "
         ++ string_of_int(initialSeconds)
         ++ " seconds",
       )}
    </div>
    <Target value=targetValue status=gameStatus />
  </div>;
  /* <div className="challenge-numbers">
       {this.renderChallengeNumbers()}
     </div>
     {this.renderFooter()}*/
};