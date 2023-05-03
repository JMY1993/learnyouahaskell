import System.IO (withFile, hGetContents, IOMode (ReadMode))
-- main = do
--     putStrLn "Enter the filename here: "
--     fName <- getLine
--     withFile fName ReadMode (\handle -> do
--             contents <- hGetContents handle
--             putStr contents)

main = do
    putStrLn "Enter the filename here: "
    fName <- getLine
    contents <- withFile fName ReadMode hGetContents
    putStr contents