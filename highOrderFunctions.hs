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
problem: Let's find the largest number under 100,000 that's divisible by 3829.
-}

largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [10000,9999..])
  where p x = x `mod` 3829 == 0

{-
problem: find the sum of all odd squares that are smaller than 10,000
-}

sumOfAllOddSquareSmallerThan10000 :: Integer
sumOfAllOddSquareSmallerThan10000 = sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))

{-
problem: Collatz sequences. We take a natural number. If that number is even, 
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
function: sum'
implement the sum function with foldl
-}

sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

{-
function: elem'
implement it with foldl
-}
elem' :: (Eq a) => a -> [a] -> Bool
elem' x = foldl (\acc e -> acc || x == e) False