import qualified Monad.StateMonad as MState

type Stack a = [a]

pop :: MState.State' (Stack a) a
pop = MState.State' (\(x:xs) -> (x, xs))

push :: a -> MState.State' (Stack a) ()
push a = MState.State' (\xs -> ((), a:xs))

{-
below is series of funtions that takes an Int value and returns State' Int (Stack Int)
-}

initStackWith :: [a] -> MState.State' (Stack a) ()
initStackWith xs = MState.State' (const ((), xs))