import Monad.StateMonad

type Stack a = [a]

pop :: State' (Stack a) a
pop = State' (\(x:xs) -> (x, xs))

push :: a -> State' (Stack a) ()
push a = State' (\xs -> ((), a:xs))

{-
below is series of funtions that takes an Int value and returns State' Int (Stack Int)
-}

initStackWith :: [a] -> State' (Stack a) ()
initStackWith xs = State' (const ((), xs))