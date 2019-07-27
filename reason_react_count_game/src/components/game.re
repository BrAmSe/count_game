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
// FUNCTIONS
// /////////////////////////////////////////////////////////
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

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
[@react.component]
let make = (~iSeconds, ~challengeSize, ~challengeRange, ~answerSize) => {
  let (gameStatus, setGameStatus) = React.useState(() => "new");
  let (initialSeconds, setInitialSeconds) = React.useState(() => iSeconds);
  let (accum, setAccum) = React.useState(() => 0);

  let (challengeOptions, targetValue) =
    generateOptions(challengeSize, challengeRange, answerSize);

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  let renderChallengeOptions = challengeOptions => {
    List.mapi(
      (index, option) =>
        <Option
          key={string_of_int(index)}
          value=option
          gameStatus
          selectOption={() => {}}
          deselectOption={() => {}}
        />,
      challengeOptions,
    );
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
           Array.of_list(renderChallengeOptions(challengeOptions)),
         )}
      </div>
    </div>
  </div>;
  /*{this.renderFooter()}*/
};