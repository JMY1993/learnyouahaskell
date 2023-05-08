{-
requirements: we are building a reverse polish calculator, which will take a string like "10 4 3 + 2 * -" and calculate it

The solution is a personal solution, which works well. But it's type declaration isn't `(Num a) => String -> a` as required.
-}

-- rpc :: (Num a) => String -> a
rpc :: String -> Int
rpc exp = case foldl process [] $ words exp of [result] -> result

-- process :: (Num a) => [a] -> String -> [a]
process :: [Int] -> String -> [Int]
process stack [] = stack
process (a1 : a2 : rest) x =
    case getOperator x of Nothing -> read x : a1 : a2 : rest
                          (Just op) -> op a2 a1 : rest
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