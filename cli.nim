import os

proc fluxCli(): (string, string) =
  let args = commandLineParams()
  if args.len != 2:
    quit("Usage: ./transmutator <input> <output>")
  (args[0], args[1])
