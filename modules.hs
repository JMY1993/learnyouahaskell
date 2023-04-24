import Data.List (tails)

{-
function 1: search
-}

search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack =
  let lenN = length needle
   in foldl (\acc x -> (needle == take lenN x) || acc) False $ tails haystack

{-
if implement without tails function, it could be complicated.
Since fold take the head of a list each time, it could not work on tasks like "take
the first few chars a head of a string and check whether it is what we want"
-}

search' :: (Eq a) => [a] -> [a] -> Bool
search' needle haystack@(x:xs)
    | length haystack < nlen = False
    | otherwise = take nlen haystack == needle || search' needle xs
--                                             TODO: ^ does haskell support short circuit calc?
    where nlen = length needle

