let listSample = (list, n) => {
  List.take(Belt.List.shuffle(list), n)
}

let rec sum = (list) => {
  switch list {
    | list{head} => head
    | list{head, ...tail} => head + sum(tail)
    | list{} => failwith("This should never happen")
  }
}

let randomNumber = (min, max) => {
  Random.init(int_of_float(Js.Date.now()))
  let random = Random.int(max - min)
  random + min
}

let rec randomListOfSize = (min: int, max: int, size: int) =>{
  if (size <= 0) {
    list{}
  } else {
    list{randomNumber(min, max), ...randomListOfSize(min, max, size - 1)}
  }
}