import MyModules.BinarySearchTree

data TreeCrumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)
type TreeZipper a = (Tree a, [TreeCrumb a])

goLeft :: TreeZipper a -> TreeZipper a
goLeft (Node item l r, cs) = (l, RightCrumb item r:cs)

goRight :: TreeZipper a -> TreeZipper a
goRight (Node item l r, cs) = (r, LeftCrumb item l:cs)

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