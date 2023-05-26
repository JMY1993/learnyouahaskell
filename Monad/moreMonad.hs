import Control.Monad ((>=>))
{-
in this sourcefile, a series of function working on monadic values are covered
-}

{-
we have a few tasks in this cource file:

TODO:
1. implement the monadic type Writer, as understand what an inefficient list construction is
2. implement the difference list
3. implement the Reader type
4. [x] implement the stateful computation Monad (done in "./StateMonad.hs")
5. wrap error in Either
6. implement function liftM
7. implement function join
8. TODO: implement function filterM
9. [x] implement foldM
10. [x] make a safe RPN calculator
11. [x] learn to compose monadic functions
12. learn how to make monads
-}

{-task 9: about foldM
1. given a list of functions (type: [a -> b]), how to compose all of them, from right to left, one by one
2. given a list of monadic functions (type: [a -> m b]), how to compose them
3. TODO: implement foldM
-}

composeL :: [a -> a] -> a -> a
composeL = foldr1 (.)

composeML :: (Monad m) => [a -> m a] -> a -> m a
composeML = foldr1 (>=>)

composeML' :: (Monad m) => [a -> m a] -> a -> m a
composeML' = foldl1 (>=>)
-- attention that no matter you use foldl or foldr to make the composeML function, it will apple the first function and then the second, all the way to the last one

{- TODO: task 10: make a safe RPN calculator
the previous algo we use to build the rpn calculator isn't robust. Because it requires the input string to conform strictly to the reverse polish expression format

we are now making a revised version of the RPN calculator, which will still product the result when given proper string as input but is also able to give a Nothing as result when fed with
a rotten expression that doesn't comply with what it requires.
-}