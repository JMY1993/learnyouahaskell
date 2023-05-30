import System.IO (withFile, hGetContents, IOMode (ReadMode))
import qualified MyModules.MyFile as MF
main = do
    putStrLn "Enter the filename here: "
    fName <- getLine
    MF.withFile' fName ReadMode (\handle -> do
            contents <- hGetContents handle
            putStr contents)
{-
TODO: the following is just my opinion. Now I think it about might be wrong.
the following code won't work, because the handle is closed inside function `withFile`. It means that
you have to finish all the IO actions inside the function that you pass as parameter, since there will be no handle
that is open outside `withFile`

secondly, withFile returns an IO (), which prohibits taking values out

^
|
that might be not true.

The reason why the following doesn't work might because of the lazyness of haskell. It won't read the file immediately and
put the contents into the RAM, but read when it needs. so the read happens when putStr asks its nested function for things
to put on the screen, at which time the handle will have already been closed. Maybe that's why we get the error msg:
illegal operation (delayed read on closed handle)


main = do
    putStrLn "Enter the filename here: "
    fName <- getLine
    contents <- withFile fName ReadMode hGetContents
    putStr contents
-}

-- main = do
--     putStrLn "Enter the filename here: "
--     fName <- getLine
--     contents <- MF.withFile' fName ReadMode hGetContents
--     putStr contents