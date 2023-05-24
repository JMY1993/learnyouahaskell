import Monad.StateMonad
import System.Random

randomSt :: (RandomGen g, Random a) => State' g a
randomSt = State' random

threeCoins :: State' StdGen (Bool, Bool, Bool)
threeCoins = do
    a <- randomSt
    b <- randomSt
    c <- randomSt
    (x, y, z) <- return (a,b,c)
    return (not x, not y, not z)