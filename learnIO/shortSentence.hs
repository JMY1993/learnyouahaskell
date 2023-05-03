import Data.Char

main = do
    contents <- getContents
    putStr $ noMoreThan 10 contents

noMoreThan :: Int -> String -> String
noMoreThan x str =
    let l = lines str
        shortLines = filter (\a -> length a <= x) l
        result = unlines shortLines
    in
        result