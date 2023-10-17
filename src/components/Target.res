// //////////////////////////////////////////////////////////
// FUNCTIONS
// /////////////////////////////////////////////////////////
let targetClass = (status: string) => {
  switch (status) {
  | "playing" => "badge secondary"
  | "won" => "badge success"
  | "lost" => "badge danger"
  | _ => "badge"
  };
};

// //////////////////////////////////////////////////////////
// COMPONENT
// /////////////////////////////////////////////////////////
@react.component
let make = (~value: int, ~status: string) => {
  <h1>
    <span className={targetClass(status)}>
      {React.string(string_of_int(value))}
    </span>
  </h1>;
};