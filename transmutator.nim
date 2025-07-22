import tensorops, utils, entropyspace
import math, sequtils, random, strutils

type
  QTensor = seq[seq[float64]]
  PolyState = object
    entropy: QTensor
    vector: seq[float64]
    pivot: int

proc genQTensor(n: int): QTensor =
  result = newSeqWith(n, newSeqWith(n, rand(1000.0)))

proc metaFold(t: QTensor; f: int): QTensor =
  let s = len(t)
  result = newSeqWith(s, newSeq[float64](s))
  for i in 0..<s:
    for j in 0..<s:
      result[i][j] = t[(i+f) mod s][(j+f*i) mod s] * sin(t[j][i])

proc encodePoly(s: string; state: var PolyState): seq[int] =
  for i, c in s:
    state.pivot = (state.pivot * 17 + ord(c)) mod len(state.vector)
    state.vector[state.pivot] = sqrt(abs(sin(ord(c) * state.entropy[state.pivot mod len(state.entropy)][i mod len(state.entropy)])))
    result.add(int(state.vector[state.pivot]*1_000_000) mod 257)

proc cryptify(input: string): string =
  var ps: PolyState
  ps.entropy = genQTensor(7)
  ps.vector = newSeqWith(7, rand(1_000.0))
  ps.pivot = rand(7)
  let encoded = encodePoly(input, ps)
  encoded.mapIt($it).join(",")

when isMainModule:
  let input = readFile("input.txt")
  let output = cryptify(input)
  writeFile("output.pxct", output)
