{-
TODO:
weird:
the program as follows will firstly ask its user to enter a line, and then
gives the prompt "Please enter a line" and then print what the user has just
entered.

it's behavior is pretty much like what setTimeout will do in JavaScript
-}

main = do
    myPutLine "Please enter a line: "
    line <- getLine
    myPutLine line

myPutLine [] = return ()
myPutLine (x:xs) = do
    putChar x
    myPutLine xs