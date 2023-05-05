import System.Directory (removeFile, renameFile)
import System.Environment (getArgs, getProgName)
import System.IO (IOMode (ReadMode), hClose, hGetContents, hPutStr, openFile, openTempFile)

main = do
  args <- getArgs
  case args of
    [] -> help []
    (cmd : args) -> case lookup cmd dispatch of
        (Just action) -> action args
        Nothing -> errorExit cmd

dispatch :: [(String, [String] -> IO ())]
dispatch =
  [ ("add", add),
    ("view", view),
    ("remove", remove),
    ("--help", help),
    ("bump", bump)
  ]

add :: [String] -> IO ()
add (filePath : newItems) = do
  handle <- openFile filePath ReadMode
  (tmpFilePath, tmpHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  hPutStr tmpHandle $ unlines $ lines contents ++ newItems
  hClose handle
  hClose tmpHandle
  removeFile filePath
  renameFile tmpFilePath filePath

view :: [String] -> IO ()
view (filePath : _) = do
  handle <- openFile filePath ReadMode
  contents <- hGetContents handle
  mapM_ putStrLn $ zipWith (\n msg -> show n ++ " - " ++ msg) [0..] $ lines contents
  hClose handle

remove :: [String] -> IO ()
remove (filePath : iNums) = do
  (tmpFilePath, tmpHandle) <- openTempFile "." "temp"
  contents <- readFile filePath
  let items = zip [0..] (lines contents)
      indices = map read iNums
      itemsNew = filter (\(num, _) -> num `notElem` indices) items
      result = unlines $ map snd itemsNew
  hPutStr tmpHandle result
  hClose tmpHandle
  removeFile filePath
  renameFile tmpFilePath filePath

help :: [String] -> IO ()
help _ = do
    putStrLn "Usage:"
    putStrLn "simpleTodo add [path] [task1] [task2] ..."
    putStrLn "simpleTodo view [path]"
    putStrLn "simpleTodo remove [path] [task number1] [task number2] [task number3] ..."

bump:: [String] -> IO ()
bump [filePath, num] = do
    (tmpFilePath, tmpHandle) <- openTempFile "." "temp"
    contents <- readFile filePath
    let items = zip [0..] (lines contents)
        itemsNew = filter (\(ind, _) -> ind == read num) items ++ filter (\(ind, _) -> ind /= read num) items
        result = unlines $ map snd itemsNew
    hPutStr tmpHandle result
    hClose tmpHandle
    removeFile filePath
    renameFile tmpFilePath filePath

errorExit :: String -> IO ()
errorExit cmd = do
    putStrLn ("Error: command " ++ "\"" ++ cmd ++ "\" " ++ "does not exist!")
    putStr "\n"
    help []