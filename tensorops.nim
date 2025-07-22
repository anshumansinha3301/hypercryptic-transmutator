proc transscale(m: seq[seq[float64]], s: float64): seq[seq[float64]] =
  for r in m:
    result.add(r.mapIt(it * s * sin(sqrt(abs(it)))))
