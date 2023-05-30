module MyModules.BinarySearchTree
  ( Tree (..),
    singleton,
    treeInsert,
    treeElem,
    treeFromList
  )
where

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

-- TODO: instance Tree as Monad
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: Ord a => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)

treeFromList :: (Ord a) => [a] -> Tree a

{-
question: why the following code is recognized as a foldr by the compiler, but it seems to be a foldl since
it starts from the left-most value?

The lsp suggests to reform the code:
    treeFromList [] = EmptyTree
    treeFromList (x:xs) = treeInsert x (treeFromList xs)

to this one:
    treeFromList = foldr treeInsert EmptyTree

answer: if we unfold the expression:
treeInsert x1 (treeFormList xs)
= t x1 (t x2 (t x3 (t x4 (t x5 EmptyTree))))
                            ^ the first value that is calculated is x5, which is at the end of the list
-}
treeFromList = foldr treeInsert EmptyTree

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a = treeElem x left
    | x > a = treeElem x right