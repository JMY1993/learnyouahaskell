-- learnyouahaskell unit 2 Syntax in Functions

swapTupleXY :: (Num a) => (a, a) -> (a, a)
swapTupleXY (x1, x2) = (x2, x1)

{-
make a function which takes a list of numbers returns the sum of them
-}

mySum :: (Num a) => [a] -> a
-- mySum :: [Num] -> Num
mySum [] = 0
mySum (x : xs) = x + mySum xs

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x : _) = x

-- length' by recursion
length' :: [a] -> Int
length' [] = 0
length' (_ : xs) = 1 + length' xs

-- sum' by recursion
sum' :: [Int] -> Int
sum' [] = 0
sum' (x : xs) = x + sum' xs

-- use as patterns
countLetters :: String -> String
countLetters word@(x : xs) = "The string \"" ++ word ++ "\"" ++ " has " ++ show (length' word) ++ " words."

-- use guard to implement my own max function
myMax :: (Ord a) => a -> a -> a
myMax a b
  | a > b = a
  | otherwise = b

myCompare :: (Ord a) => a -> a -> Ordering
myCompare a b
  | a > b = GT
  | a < b = LT
  | otherwise = EQ

{-
a function giving mean comments depending on your bmi
it takes your weight and height as args
bmi = weight / height ^ 2
<=18.5 = "You're underweight, you emo, you!"
<=25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
<=30.0 = "You're fat! Lose some weight, fatty!"
otherwise = "You're a whale, congratulations!"
-}

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"
  where
    bmi = weight / height ^ 2
    (skinny, normal, fat) = (18.5, 25.0, 30.0)

{-
initials: we get a first and a last name and give someone back their initials.
-}
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where
        (f:_) = firstname
        (l:_) = lastname

-- pattern matching way of doing it

initials' :: String -> String -> String
initials' (f:_) (l:_) = f:". " ++ l:"."

-- try to include list pattern matching in a tuple, and it works!

initials'' :: String -> String -> String
initials'' firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where
        (f:_, l:_) = (firstname, lastname)

-- functions can also be defined in a where clause just like constants

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where
        bmi weight height = weight / height ^ 2

calcBmis' :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 23.00]

{-
this piece of code is not working:

calcBmis'' xs = [let bmi = w / h ^ 2 in bmi | (w, h) <- xs, bmi >= 23.00]

the let binding is visible to
1. the output function
2. the predicates
3. sections that come after of the binding

the input part is defined prior to the other parts of the list comprehension

calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 23.00]  
                ^third     ^first            ^second        ^last
-}
describeList :: [a] -> String  
describeList xs = "The list is " ++ what xs  
    where 
        what :: [a] -> String
        what xs = case xs of [] -> "empty."
                             [x] -> "a singleton list."  
                             xs -> "a longer list."
          