import System.IO (openFile, IOMode (ReadMode), hGetContents, hClose)
main = do
    putStrLn "Enter file name here: "
    fName <- getLine
    handle <- openFile fName ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle