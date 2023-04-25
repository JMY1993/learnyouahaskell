import Data.List

{-
function1: zipWith'

It takes a function and two lists as parameters and then joins the
two lists by applying the function between corresponding elements.
-}

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
{-at first, I came up with this implementation, but it failed
zipWith' f xs ys = [f x y | x <- xs, y <- ys]
                     ^ will apply every possible pairs of x and y
                     which means redundancy
-}
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

{-
function2: flip'

takes a function and returns a function that is like our original
function, only the first two arguments are flipped.
-}

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = f'
  where
    f' x y = f y x

-- since symbol -> is right associative by default
-- (a->b->c) -> (b->a->c) is the same as (a->b->c) -> (b->(a->c))
-- is the same as (a->b->c) ->b->a->c

flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f x y = f y x

{-
function3: map'takes a function and a list and applies that function
to every element in the list
-}

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs

{-
function4: filter'
takes a predicate (a predicate is a function that tells whether something
is true or not, so in our case, a function that returns a boolean value)
and a list and then returns the list of elements that satisfy the predicate.
-}
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x : xs)
  | p x = x : filter' p xs
  | otherwise = filter' p xs

{-
problem1: Let's find the largest number under 100,000 that's divisible by 3829.
-}

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [10000,9999..])
  where p x = x `mod` 3829 == 0

{-
problem2: find the sum of all odd squares that are smaller than 10,000
-}

sumOfAllOddSquareSmallerThan10000 :: Integer
sumOfAllOddSquareSmallerThan10000 = sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))

{-
problem3: Collatz sequences. We take a natural number. If that number is even, 
we divide it by two. If it's odd, we multiply it by 3 and then add 1 to that. 
We take the resulting number and apply the same thing to it, which produces a 
new number and so on. In essence, we get a chain of numbers. It is thought 
that for all starting numbers, the chains finish at the number 1. So if we 
take the starting number 13, we get this sequence: 13, 40, 20, 10, 5, 16, 8, 
4, 2, 1. 13*3 + 1 equals 40. 40 divided by 2 is 20, etc. We see that the 
chain has 10 terms

Now what we want to know is this: for all starting numbers between 1 and 100, 
how many chains have a length greater than 15? First off, we'll write a 
function that produces a chain:
-}
collatzChain :: Integral a => a -> [a]
collatzChain x
  | x == 1 = [1]
  | even x = x : collatzChain (x `div` 2)
  --                               ^ use `div` not `/`here
  -- div return an integral number while `/` returns a floating number
  | odd x = x : collatzChain (x*3 + 1)

chainsLongerThan15 :: Int
chainsLongerThan15 = length (filter (>15) (map (length . collatzChain) [1..100]))

{-
function5: sum'
implement the sum function with foldl
-}

sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

{-
function6: elem'
implement it with foldl
-}
elem' :: (Eq a) => a -> [a] -> Bool
elem' x = foldl (\acc e -> acc || x == e) False

{-
function7: map'
implement it with foldr
-}

map'' :: (a -> b) -> [a] -> [b]
map'' f = foldr (\x acc -> (f x):acc) []

-- implement map with foldl
{- SOLVED:
if we run the code: take 5 (mapl (+3) [1..]), the programme falls into an infinite loop
that's because 'foldl' doesn't work on an infinite loop, it is, as explained by the book,
if you take an infinite list at some point and you fold it up from the right, you'll 
eventually reach the beginning of the list. However, if you take an infinite list at a 
point and you try to fold it up from the left, you'll never reach an end!

let's take `foldl f acc [x1, x2, x3 ...]` as example, expand it:
steps:
1   a = f acc x1
2   a = f a1 x2 
       = f (f acc x1) x2
3   a = f (f (f acc x1) x2) x3
4   a = f (f (f (f acc x1) x2) x3) x4

if it's not clear enough for the above, let's try: `flip (foldl f) [x1, x2, x3 ...] acc`:
1   a = f x1 acc
2   a = f x2 $ f acc x1
3   a = f x3 $ f x2 $ f acc x1
4   a = f x4 $ f x3 $ f x2 $ f acc x1
...
l2  a = f xlb2 $ ... $ f x4 $ f x3 $ f x2 $ f acc x1
l1  a = f xlb1 $ f xlb2 $ ... $ f x4 $ f x3 $ f x2 $ f acc x1

in order to work on the evaluation, the last element shall be provided (accessible), so
it's not working on infinite lists. On the contrary, when we expand a foldr evaluation:

`foldl f [x1, x2, x3 ...] acc`
steps: (xlb = x-last-but-)
1   a = f xlb1
2   a = f x-last-but-2 a1
       = f xlb2 (f xend acc)
4   a = f xlb3 (f xlb2 (f xlb1 acc))
...
l3  a = f x3 $ ... $ f xlb2 $ f xlb1 acc
l2  a = f x2 $ f x3 $ ... $ f xlb2 $ f xlb1 acc
l1  a = f x1 $ f x2 $ f x3 $ ... $ f xlb3 $ f xlb2 $ f xlb1 acc

Hakell is lazy: it only takes as many as it was told
-}
mapl :: (a->b) -> [a] -> [b]
mapl f = foldl (\acc e -> acc ++ [f e]) []

-- still stuck
mapl' :: (a->b) -> [a] -> [b]
mapl' f = foldl' (\acc e -> acc ++ [f e]) []

{-
function 8 - 13
implement maximum, reverse, product, filter, head, last
with foldl,foldr,foldl1,foldr1
-}
maximum'' :: (Num a, Ord a) => [a] -> a
maximum'' = foldl max 0 -- or `foldl1 max`

reverse'' :: [a] -> [a]
reverse'' = foldl (flip (:)) []

product'' :: (Num a) => [a] -> a
product'' = foldl1 (*)

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f = foldr (\x acc -> if f x then x : acc else acc) []
-- to use the pre-defined accumulator fold, be sure to check that 
-- the return type and the type of the first element of the list is of the same type