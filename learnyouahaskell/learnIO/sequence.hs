main = do
--   a <- getLine
--   b <- getLine
--   c <- getLine
--   print [a, b, c]
-- is the same as:
    rs <- sequence [getLine, getLine, getLine]
    print rs

{-IO actions on list items has their own logic

let's take map as an example, let make our own putStrLn function out of putChar

if we try to run the code:
myPutStr = map putCharwe will get an error prompt that  No instance for (Show (IO ())) arising from a use of ‘print’ 
which is clear that type (IO ()) is not an instance of Show

now we derive it like this :

instance Show (IO ()) where
    show _ = "random string"

and we run the code, we get a line: [random string,random string,random string,random string,random string,random string]

that's reasonable, only we didn't see the result we would like to see from the function "putChar". We expect to see something
like: shift[random string,random string,random string,random string,random string,random string] 

that's probably because putChar is tainted, and may live outside the pure world

if we sequence the above result, it works!

if we change map into mapM, it works!

if we change map into mapM_, it works! only we have to change the type delcaration to
myPutStr :: [Char] -> IO ()

type declarations:
sequence :: [IO a] -> IO [a]

mapM :: (a -> IO a) -> [a] -> IO [a]

-}

instance Show (IO ()) where
    show _ = "random string"

-- myPutStr :: [Char] -> IO [()]
-- myPutStr str = sequence $ map putChar str
-- myPutStr = mapM putChar
myPutStr :: [Char] -> IO ()
myPutStr = mapM_ putChar
