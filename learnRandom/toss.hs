import System.Random (Random (randomRs), StdGen, mkStdGen, random)

{-
requirements:

make a toss function which takes as its parameter an Int number, and makes a list of random number in contigent with it
-}

-- toss :: Int -> a -> [Random]

toss :: Random a => StdGen -> [a]
toss seed =
  let (result, nextSeed) = random seed
   in result : toss nextSeed

tossN :: Random a => Int -> StdGen -> [a]
tossN n seed = take n $ toss seed

randomStrings :: Int -> StdGen -> [String]
randomStrings lth = cutStream lth . randomRs ('a', 'z')
        where
            cutStream lth stream =
                let (head, tail) = splitAt lth stream
                in head:cutStream lth tail