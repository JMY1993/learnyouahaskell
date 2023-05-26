{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use >=>" #-}
module Monad.Compose where

infixr 9 <=<
(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = \x -> g x >>= f

{-
in the package Control.Monad, there is a function (>=>) that can do composition between monadic functions, only their parameter are in the reverse order
as function (.)
-}