import Control.Monad (forever, forM)
import Data.Char (toUpper)

{-
for the following code, we find every time the getLine is excuted before the putStr, why is that?

main = forever $ do
  putStr "Give me some input: "
  i <- getLine
  putStrLn $ map toUpper i
-}

-- main = forever $ do
--   putStrLn "Give me some input: "
--   i <- getLine
--   putStrLn $ map toUpper i


-- forM and mapM are alike, only their parameters switched around. But mapM_ doesn't produce a return value, which is thrown away

-- main = do
--     colors <- forM [1..4] (\a -> do
--         putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
--         getLine)
--     putStrLn "The color that you associate with 1, 2, 3 and 4 are: "
--     mapM putStrLn colors

-- we can rewrite the program with mapM as follows:
main = do
    colors <- mapM (\a -> do
        putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
        getLine) [1..4]
    putStrLn "The color that you associate with 1, 2, 3 and 4 are: "
    mapM putStrLn colors