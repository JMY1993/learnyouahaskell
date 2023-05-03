import Control.Monad (forever)
import Data.Char ( toUpper )
main = forever $ do
    contents <- getContents
    putStr (map toUpper contents)