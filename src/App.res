%%raw("import * as papercss from 'papercss/dist/paper.css';")
%%raw("import * as styles from './styles.css';")

@react.component
let make = () => {
  <section className="row">
    <div className="md-12 col">
      <header className="row flex-center flex-middle">
        <picture className="align-items">
          <img className="no-border logo" src="./count_mathcula.png" />
        </picture>
        <div className="text-center">
          <h1> {React.string("Count Mathcula")} </h1>
          <h3> {React.string("The most nobleman math game ever!")} </h3>
        </div>
      </header>
      <div className="App-intro">
        <Game
          iSeconds=30
          challengeSize=6
          challengeRange=(1, 10)
          answerSize=4
        />
      </div>
    </div>
  </section>;
};