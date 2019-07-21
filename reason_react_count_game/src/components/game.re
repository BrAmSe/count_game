type state = {
  gameStatus: string,
  initialSeconds: int,
  accum: int,
};

type action =
  | SaveFields;

let component = ReasonReact.reducerComponent("Game");

let make = (~initialSeconds, _children) => {
  ...component,
  initialState: () => {
    gameStatus: "new",
    initialSeconds: initialSeconds,
    accum: 0,
  },
  reducer: (action: action, _state: state) => {
    switch(action) {
      | _ => ReasonReact.NoUpdate
    }
  },
  render: _self => {
    <div className="game">
      <div className="help">
        (ReasonReact.string("Pick numbers that sum to the target in " ++ string_of_int(_self.state.initialSeconds) ++ " seconds"))
      </div>
      /* <Target value={this.target} status={this.state.gameStatus}></Target>
      <div className="challenge-numbers">
        {this.renderChallengeNumbers()}
      </div>
      {this.renderFooter()}*/
    </div>
  }
}