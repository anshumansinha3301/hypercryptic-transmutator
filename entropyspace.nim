import random

proc quantumFuzz(n: int): seq[float64] =
  for _ in 0..<n:
    result.add(rand(1_000_000.0) * exp(rand(1.0)))
