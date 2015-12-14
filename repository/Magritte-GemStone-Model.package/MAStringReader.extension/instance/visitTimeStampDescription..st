*magritte-gemstone-model
visitTimeStampDescription: aDescription
  | date time |
  stream skipSeparators.
  date := Date readFrom: stream.
  stream skipSeparators.
  time := Time readFrom: stream.
  self object: (aDescription kind date: date time: time)