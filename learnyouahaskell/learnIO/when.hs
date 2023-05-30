import Control.Monad (when)
main = do
    c <- getChar
    when (c /= ' ') $ do
        print c
        main