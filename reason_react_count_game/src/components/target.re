let targetClass = (status: string) => {
  switch (status) {
  | "playing" => "target playing"
  | "won" => "target won"
  | "lost" => "target lost"
  | "new" => "target new"
  | _ => "target"
  };
};

[@react.component]
let make = (~value: int, ~status: string) => {
  <div className={targetClass(status)}>
    {React.string(string_of_int(value))}
  </div>;
};