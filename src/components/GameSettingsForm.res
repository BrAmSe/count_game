// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
@react.component
let make = (~initialValues, ~onSubmit) => {

  let (formValues, setFormValues) = React.useState(
    () => {
      {
        "challengeMaxValue": Some(initialValues["challengeMaxValue"]),
        "challengeMinValue": Some(initialValues["challengeMinValue"]),
        "challengeSize": Some(initialValues["challengeSize"])
      }
    }
  )

  let (formErrors, setFormErrors) = React.useState(() => [])

  let handleInputChange = (value, name: string) => {
    setFormValues(oldFormValues => {
      let newFormValues = Object.copy(oldFormValues)
      newFormValues -> Object.set(name, value)
      newFormValues
    })
  }

  let validatePresence = (object) => {
    let errorsArray = [];
    if (object["challengeSize"] == None) {
      Array.push(errorsArray, "Number of inputs cannot be empty")
    }
    if (object["challengeMaxValue"] == None) {
      Array.push(errorsArray, "Superior border value for options cannot be empty")
    }
    if (object["challengeMinValue"] == None) {
      Array.push(errorsArray, "Inferior border value for options cannot be empty")
    }
    errorsArray
  }

  let validateBoundaries = (object) => {
    let errorsArray = [];
    let challengeSize = object["challengeSize"];
    let challengeMinValue = object["challengeMinValue"];
    let challengeMaxValue = object["challengeMaxValue"];

    switch challengeSize {
    | Some(challengeSizeValue) if challengeSizeValue <= 4 || challengeSizeValue > 40 => Array.push(
        errorsArray,
        "Number of inputs should be between 4 and 40",
      )
    | _ => ()
    }
    switch(challengeMaxValue, challengeMinValue) {
      |(Some(challengeMaxValueValue), Some(challengeMinValueValue)) => {
        if (challengeMinValueValue < 0) {
          Array.push(errorsArray, `Inferior border value for options should be bigger than 0`)
        } else if (challengeMaxValueValue <= challengeMinValueValue) {
          Array.push(errorsArray, `Superior border value for options should be bigger than ${string_of_int(challengeMinValueValue)}`)
        }
      }
      |_ => ()
    }
    errorsArray
  }

  let submitForm = (evt) => {
    ReactEvent.Mouse.preventDefault(evt)
    let errors = Array.concat(validatePresence(formValues), validateBoundaries(formValues))
    if (Array.length(errors) == 0) {
      setFormErrors(_ => [])
      switch(formValues["challengeSize"], formValues["challengeMaxValue"], formValues["challengeMinValue"]) {
        | (Some(challengeSizeValue), Some(challengeMaxValueValue), Some(challengeMinValueValue)) => {
          onSubmit({"challengeSize": challengeSizeValue, "challengeMaxValue": challengeMaxValueValue, "challengeMinValue": challengeMinValueValue })
        }
        |_ => ()
      }
    } else {
      setFormErrors(_ => errors)
    }
  }

  let renderErrors = () => {
    let paragraphErrors = formErrors -> Array.map((error) => {
      <p className="text-danger">{React.string(error)}</p>
    })
    if (Array.length(paragraphErrors) > 0) {
      <div className="form-group">
        <h4>{React.string("Something went wrong: ")}</h4>
        {React.array(paragraphErrors)}
      </div>
    } else {
      <></>
    }
  }

<form>
  <h2>{React.string("Settings: ")}</h2>
  {renderErrors()}
  <NumberInput
    labelText="Number of options"
    id="challenge-size-input"
    value={formValues["challengeSize"]}
    onChange={value => handleInputChange(value, "challengeSize")}
    name="challengeSize"
  />
  <NumberInput
    labelText="Superior border value for options"
    id="challenge-max-value-input"
    value={formValues["challengeMaxValue"]}
    onChange={value => handleInputChange(value, "challengeMaxValue")}
    name="challengeMaxValue"
  />
  <NumberInput
    labelText="Inferior border value for options"
    id="challenge-min-value-input"
    value={formValues["challengeMinValue"]}
    onChange={value => handleInputChange(value, "challengeMinValue")}
    name="challengeMinValue"
  />
  <button type_="submit" onClick={evt => submitForm(evt)}>{React.string("close")}</button>
</form>
}