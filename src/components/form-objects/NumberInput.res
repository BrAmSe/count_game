type propType = {
  value: option<int>,
  onChange: (option<int>) => unit,
  labelText: string,
  id: string,
  name: string
};

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
let make = (props: propType) => {

  let (value, setValue) = React.useState(
    () => {
      switch(props.value){
      | Some(intValue) => string_of_int(intValue)
      | None => ""
      }
    }
  )

  let handleInputChange = (event) => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setValue(value)
    if value == "" {
      props.onChange(None)
    } else {
      props.onChange(Some(int_of_string(value)))
    }
  }

  // //////////////////////////////////////////////////////////
  // RENDERS
  // /////////////////////////////////////////////////////////
  <div className="form-group">
    <label htmlFor={props.id}>{React.string(props.labelText)}</label>
    <input type_="number" id={props.id} value={value} onChange={evt => handleInputChange(evt)}/>
  </div>
}