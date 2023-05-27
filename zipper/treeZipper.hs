import MyModules.BinarySearchTree
import Monad.StateMonad

data TreeCrumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)
type TreeZipper a = (Tree a, [TreeCrumb a])

goLeft :: TreeZipper a -> TreeZipper a
goLeft (Node item l r, cs) = (l, RightCrumb item r:cs)

goRight :: TreeZipper a -> TreeZipper a
goRight (Node item l r, cs) = (r, LeftCrumb item l:cs)

goUp :: TreeZipper a -> TreeZipper a
goUp (r, LeftCrumb item l:cs) = (Node item l r, cs)
goUp (l, RightCrumb item r:cs) = (Node item l r, cs)

freeTree :: Tree Char  
freeTree =   
    Node 'P'  
        (Node 'O'  
            (Node 'L'  
                (Node 'N' EmptyTree EmptyTree)  
                (Node 'T' EmptyTree EmptyTree)  
            )  
            (Node 'Y'  
                (Node 'S' EmptyTree EmptyTree)  
                (Node 'A' EmptyTree EmptyTree)  
            )  
        )  
        (Node 'L'  
            (Node 'W'  
                (Node 'C' EmptyTree EmptyTree)  
                (Node 'R' EmptyTree EmptyTree)  
            )  
            (Node 'A'  
                (Node 'A' EmptyTree EmptyTree)  
                (Node 'C' EmptyTree EmptyTree)  
            )  
        )

{-now try to implement goLeft, goRight, goUp as Stateful monad-}

goLeftM :: State' (TreeZipper a) (Tree a)
goLeftM = State' (\tz -> let zipper@(item, _) = goLeft tz in (item, zipper))

goRightM :: State' (TreeZipper a) (Tree a)
goRightM = State' (\tz -> let zipper@(item, _) = goRight tz in (item, zipper))

goUpM :: State' (TreeZipper a) (Tree a)
goUpM = State' (\tz -> let zipper@(item, _) = goUp tz in (item, zipper))

-- now all the movements could be glued together with do notation or (>>)

lrl :: State' (TreeZipper a) (Tree a)
lrl = do
    goLeftM
    goRightM
    goLeftM

{-
ghci> fst $ runState' lrl (freeTree, [])
Node 'S' EmptyTree EmptyTree

OR

ghci> fst $ runState' (goLeftM >> goRightM >> goLeftM) (freeTree , [])
Node 'S' EmptyTree EmptyTree
-}