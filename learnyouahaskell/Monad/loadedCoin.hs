{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use first" #-}
{-# HLINT ignore "Use second" #-}
import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving Show

instance Functor Prob where
  fmap f (Prob xs) = Prob $ map (\(v, r) -> (f v, r)) xs

instance Applicative Prob where
    pure a = Prob [(a, 1%1)]
    (<*>) (Prob fs) (Prob as) = Prob [(f a, r*p) | (f, r) <- fs, (a, p) <- as]

instance Monad Prob where
  (>>=) m f = flatten (fmap f m)
    where flatten (Prob xs) = Prob $ concatMap flatInner xs
          flatInner (Prob ys, r) = map (\(v, p) -> (v, r*p)) ys

  return = pure


data Coin = Heads | Tails deriving (Show, Eq)

coin = Prob [(Heads, 1%2), (Tails, 1%2)]
loadedCoin = Prob [(Heads, 1%10), (Tails, 9%10)]

flipThree = do
    a <- coin
    b <- coin
    c <- loadedCoin
    return (all (==Tails) [a,b,c])
-- again, don't get confused about how list-like monad works, it's pretty like from the first value on, we split a few "thread"s (not really, just anology), each time new values were introduced
-- new thread got splitted. At the end of the (>>=) chain, all the sub-threads will get a result respetively and the final result of the do block is the list of all the results from each thread