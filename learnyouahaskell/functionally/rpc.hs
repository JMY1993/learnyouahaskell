{-
requirements: we are building a reverse polish calculator, which will take a string like "10 4 3 + 2 * -" and calculate it

The solution is a personal solution, which works well. But it's type declaration isn't `(Num a) => String -> a` as required.
This is because in order to be read as a value, the value must have a type that is part of typeclass "Read", which we can manually add to it's declaration
like this:
(Num a, Read a) => String -> a

so far so good
-}

rpc :: String -> Int
rpc = head . foldl process [] . words

-- process :: (Num a) => [a] -> String -> [a]
process :: (Num a, Read a) => [a] -> String -> [a]
process stack "" = stack
process (a1 : a2 : rest) x =
    case getOperator x of Nothing -> read x : a1 : a2 : rest
                          (Just op) -> op a2 a1 : rest
-- remember to add this pattern at the bottom, since if not, you can't catch when the stack is empty or with less than two elements when the parameter `exp` isn't null
process stack x = read x : stack

getOperator :: (Num a) => String -> Maybe (a -> a -> a)
getOperator exp = lookup exp dispatch
  where
    dispatch :: (Num a) => [(String, a -> a -> a)]
    dispatch =
      [ ("+", (+)),
        ("-", (-)),
        ("*", (*))
      ]

-- below is a solution by the textbook
solveRPN :: (Num a, Read a, Floating a) => String -> a  
solveRPN = head . foldl foldingFunction [] . words  
    where   foldingFunction (x:y:ys) "*" = (x * y):ys  
            foldingFunction (x:y:ys) "+" = (x + y):ys  
            foldingFunction (x:y:ys) "-" = (y - x):ys
            foldingFunction (x:y:ys) "/" = (y / x):ys
            foldingFunction (x:y:ys) "^" = (y ** x):ys  
            foldingFunction (x:xs) "ln" = log x:xs  
            foldingFunction xs "sum" = [sum xs]  
            foldingFunction xs numberString = read numberString:xs