import System.Random
import Control.Monad
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
    let (key, gen') = randomR (1,10) gen :: (Int, StdGen)
        parse = case reads input of
            [] -> Nothing
            [(guess, _)] -> Just guess
    -- gen' <- newStdGen
    unless (null input) $ do
        case parse of
            Nothing -> putStrLn "Please enter a number"
            (Just guess) -> if key == guess
                                then putStrLn "You are correct!"
                                else putStrLn ("Sorry, it was " ++ show key)
        askForNumber gen'