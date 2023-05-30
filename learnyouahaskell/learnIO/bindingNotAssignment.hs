import Data.Char (toUpper)

{-
in haskell, what happens in a do block isn't the way commands act in imperative languages
1. there shall be no assignment outside a "let" expression. even in a "let" expression, it's a binding 
   other than an assignment
2. the procedure to extract value from the result of an IO action is called binding, it works with a
   "<-" symbol
-}

main = do
    putStrLn "What's your first name?"
    firstName <- getLine
    putStrLn "What's your last name?"
    lastName <- getLine
    let bigFirstname = map toUpper firstName
        bigLastName = map toUpper lastName
    putStrLn $ "hey " ++ bigFirstname ++ " " ++ bigLastName ++ ", how are you?"