import System.IO (readFile)
import System.Environment (getArgs)
import Control.Exception (catch)
import System.IO.Error (isDoesNotExistError, ioeGetFileName)
main = toTry `catch` handler

toTry = do
    (fileName:_) <- getArgs
    contents <- readFile fileName
    let lineNum = length $ lines contents
    putStrLn $ "There are in total " ++ show lineNum ++ " lines in file " ++ fileName

handler :: IOError -> IO ()
handler err
    | isDoesNotExistError err = 
        case ioeGetFileName err of Nothing -> putStrLn "Oh! There we go, we've got an error. While the file name isn't available now."
                                   (Just fName) -> putStrLn $ "Oh! There we go, we've got an error: " ++ fName ++ " doesn't exist."
    | otherwise = ioError err