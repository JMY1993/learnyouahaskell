import Data.List (tails, groupBy)
import Data.Char (isAlphaNum, isSpace)
import Data.Function ( on )
import Data.Foldable ( all )
import qualified Data.Map as Map
import qualified Data.Set as Set

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
the first few chars ahead of a string and check whether it is what we want"
-}

search' :: (Eq a) => [a] -> [a] -> Bool
search' needle haystack@(x:xs)
    | length haystack < nlen = False
    | otherwise = take nlen haystack == needle || search' needle xs
--                                             TODO: ^ does haskell support short circuit calc?
    where nlen = length needle

{-
function: words
-}

words' :: String -> [String]
words' = filter (not . any isSpace) . groupBy ((==) `on` isAlphaNum)