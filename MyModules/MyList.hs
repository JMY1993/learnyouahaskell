module MyModules.MyList
  ( MyList (..),
    (##),
  )
where

infixr 5 :-:

data MyList a where
  Empty :: MyList a
  (:-:) :: a -> MyList a -> MyList a
  deriving (Show, Read, Eq, Ord)

-- TODO: GADT syntax? what is that?

-- un implement of operator `++` 
infixr 5 ##

(##) :: MyList a -> MyList a -> MyList a
Empty ## b = b
(x :-: xs) ## b = x :-: (xs ## b)