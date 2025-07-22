proc covertMix(x: seq[int]): seq[int] =
  result = @[int(hash(x) mod 997)]
  for i in x:
    result.add((i * int(sin(i))) mod 257)
