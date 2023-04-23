{- function 1
The maximum function takes a list of things that can be ordered
(e.g. instances of the Ord typeclass) and returns the biggest of them.
-}
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x : xs)
  | x > maxTail = x
  | otherwise = maxTail
  where
    maxTail = maximum' xs

{- function 2
replicate takes an Int and some element and returns a list that has several
repetitions of the same element.

Note: Num is not a subclass of Ord. That means that what constitutes for a
number doesn't really have to adhere to an ordering. So that's why we have
to specify both the Num and Ord class constraints when doing addition or
subtraction and also comparison.
-}
-- using pattern matching
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n - 1) x

-- using guard
replicate'' :: (Num i, Ord i) => i -> a -> [a]
replicate'' n x
  | n <= 0 = []
  | otherwise = x : replicate'' (n - 1) x

{- function 3
take'
It takes a certain number of elements from a list.
-}

-- using pattern matching
-- this approach fails when taking a negative number of elements,
-- for it doesn't handle such cases
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' 0 _ = []
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

-- using guards
take'' :: (Num i, Ord i) => i -> [a] -> [a]
take'' n (x : xs)
  | n <= 0 = []
  | otherwise = x : take'' (n - 1) xs
take'' _ [] = []

-- standard implement by the author of the book
take''' :: (Num i, Ord i) => i -> [a] -> [a]
take''' n _
  | n <= 0 = []
take''' _ [] = []
take''' n (x : xs) = x : take''' (n - 1) xs

{- function 4
reverse' simply reverses a list
-}
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x : xs) = reverse' xs ++ [x]

{- function 5
repeat' takes an element and returns an infinite list that just has that element.
-}

repeat' :: a -> [a]
repeat' a = a : repeat' a

{- function 6
zip' takes two lists and zips them together. zip [1,2,3] [2,3] returns [(1,2),(2,3)]
 it truncates the longer list to match the length of the shorter one.
-}
zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x : xs) (y : ys) = (x, y) : zip' xs ys

{- function 7
elem' It takes an element and a list and sees if that element is in the list.
infix functions can be defined also in an infix way, which makes it more straightforward
-}
-- using guards
elem' :: (Eq a) => a -> [a] -> Bool
e `elem'` [] = False
e `elem'` (x : xs)
  | e == x = True
  | otherwise = e `elem'` xs

-- using pattern matching
-- elem'' :: (Eq a) => a -> [a] -> Bool
-- e `elem''` [] = False
-- e `elem''` (e : _) = True
--            ^ failed
-- e `elem''` (x : xs) = e `elem''` xs

{- function 8
quicksort
-}

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted = quicksort [a | a <- xs, a > x]
   in smallerSorted ++ [x] ++ biggerSorted