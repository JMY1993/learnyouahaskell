import System.Random
{-
requirements:
make a program that asks your user for a number each time, with which the program compares a randomly generated number.

prompt:  "Which number in the range from 1 to 10 am I thinking of? "  
on right: "You are correct!"  
on wrong: "Sorry, it was " ++ the correct number  
-}
main = do
    gen <- getStdGen
    askForNumber gen

askForNumber :: StdGen -> IO ()
askForNumber gen = do
    putStrLn "Which number in the range from 1 to 10 am I thinking of?"
    input <- getLine
    let (key, gen') = randomR (1,10) gen
        guess = read input :: Int
    -- gen' <- newStdGen
    if key == guess
        then do putStrLn "You are correct!"
        else do putStrLn ("Sorry, it was " ++ show key)
    askForNumber gen'