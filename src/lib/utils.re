[@bs.module "lodash"] external sum: array('a) => 'a = "sum";
[@bs.module "lodash"]
external arrSample: (array('a), int) => array('a) = "sampleSize";

let randomNumber = (min, max) => {
  Random.init(int_of_float(Js.Date.now()));
  let random = Random.int(max - min);
  random + min;
};

let rec randomListOfSize = (min: int, max: int, size: int) =>
  if (size <= 0) {
    [];
  } else {
    [randomNumber(min, max), ...randomListOfSize(min, max, size - 1)];
  };