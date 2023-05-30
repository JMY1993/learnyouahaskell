{-
this is to remind myself on how to successfully import System.Random. I've stuck here for quite a long time

System.Random is part of libaray `random` which is not battery included in a fresh new ghc installation

to globally install the lib, run:

cabal install --lib random

but installing libs globally isn't a good idea, which I will learn to improve once I learn it.
-}
import System.Random (Random(random))
