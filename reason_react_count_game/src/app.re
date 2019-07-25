[%bs.raw {|require('./app.css')|}];

[@bs.module] external logo: string = "./logo.svg";

[@react.component]
let make = (~message) => {
  <div className="App">
    <div className="App-header">
      <img src=logo className="App-logo" alt="logo" />
      <h2> {React.string(message)} </h2>
    </div>
    <div className="App-intro">
      <Game iSeconds=30 challengeSize=6 challengeRange=(1, 10) answerSize=4 />
    </div>
  </div>;
};