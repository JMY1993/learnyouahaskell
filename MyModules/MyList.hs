module MyModules.MyList (MyList (..)) where

infixr 5 :-:

data MyList a where
  Empty :: MyList a
  (:-:) :: a -> MyList a -> MyList a
  deriving (Show, Read, Eq, Ord)
  --TODO: GADT syntax? what is that?