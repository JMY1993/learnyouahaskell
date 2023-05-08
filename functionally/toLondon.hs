main = do
    putStrLn "Please input the route data (the total number of numbers your entered shall be multiple of 3):"
    contents <- getLine
    let
        numbers = map read $ words contents
        shortest = shortestPath . toNet $ numbers
    print shortest

toNet :: (Num a, Ord a) => [a] -> [NetSec a]
toNet [] = []
toNet (a:b:c:cs) = NetSec a b c : toNet cs


data Route = A | B deriving (Eq)

data NetSec a = NetSec {routeA :: a, routeB :: a, cross :: a} deriving (Show)

type Net a = [NetSec a]

shortestPath :: (Num a, Ord a) => Net a -> a
shortestPath net = min (chooseRoute A net 0) (chooseRoute B net 0)

chooseRoute::(Num a, Ord a) => Route -> Net a -> a -> a
chooseRoute _ [] prev = prev
chooseRoute r (sec:restNet) prev =
    case r of A -> min (chooseRoute A restNet (prev + routeA sec)) (chooseRoute B restNet (prev + routeA sec + cross sec))
              B -> min (chooseRoute B restNet (prev + routeB sec)) (chooseRoute A restNet (prev + routeB sec + cross sec))