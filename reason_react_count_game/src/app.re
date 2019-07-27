[%bs.raw {|require('papercss/dist/paper.css')|}];

[@bs.module] external logo: string = "./logo.svg";

[@react.component]
let make = (~message) => {
  <div className="row site flex-center">
    <div className="md-10 col">
      <div className="paper">
        <div className="row flex-center">
          <div className="text-center">
            <h1> {React.string("Count Mathcula")} </h1>
            <h3> {React.string("The most nobleman math game ever!")} </h3>
          </div>
        </div>
        <div className="App-intro">
          <Game
            iSeconds=30
            challengeSize=6
            challengeRange=(1, 10)
            answerSize=4
          />
        </div>
      </div>
    </div>
  </div>;
};