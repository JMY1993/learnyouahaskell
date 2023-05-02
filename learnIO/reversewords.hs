{-
in haskell, return isn't what it's like in imperative languages
it doesn't bring out of the function some value, nor does it terminates the function
It's more like a wrapper that encapsulates a value within a box named IO, namely brings
in a value of "IO a" type.
-}

main = do
    putStrLn "Please enter a sentence: "
    line <- getLine
    if null line
        then return ()
        else do
            putStrLn $ unwords . map reverse . words $ line