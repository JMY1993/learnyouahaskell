main = do
    putStrLn "Please input the route data (the total number of numbers your entered shall be multiple of 3):"
    contents <- getLine
    let
        numbers = map read $ words contents
        (shortest, log) = shortestPathLog . toNet $ numbers
    putStr "The shortest route is: "
    mapM_ (\route -> putStr (show route ++ " ")) log
    putStrLn ("\nIt's distance is: " ++ show shortest)


toNet :: (Num a, Ord a) => [a] -> [NetSec a]
toNet [] = []
toNet (a:b:c:cs) = NetSec a b c : toNet cs


data Route = A | B | C deriving (Eq, Show)

data NetSec a = NetSec {routeA :: a, routeB :: a, cross :: a} deriving (Show)

type Net a = [NetSec a]

shortestPath :: (Num a, Ord a) => Net a -> a
shortestPath net = min (chooseRoute A net 0) (chooseRoute B net 0)

chooseRoute::(Num a, Ord a) => Route -> Net a -> a -> a
chooseRoute _ [] prev = prev
chooseRoute r (sec:restNet) prev =
    case r of A -> min (chooseRoute A restNet (prev + routeA sec)) (chooseRoute B restNet (prev + routeA sec + cross sec))
              B -> min (chooseRoute B restNet (prev + routeB sec)) (chooseRoute A restNet (prev + routeB sec + cross sec))

--below is a version that logs the route we choose

shortestPathLog :: (Num a, Ord a) => Net a -> (a, [Route])
shortestPathLog net = minWithLog (chooseRouteLog A net 0 []) (chooseRouteLog B net 0 [])

chooseRouteLog::(Num a, Ord a) => Route -> Net a -> a -> [Route] -> (a, [Route])
chooseRouteLog _ [] prev log = (prev, log)
chooseRouteLog r (sec:restNet) prev log =
    case r of A -> minWithLog (chooseRouteLog A restNet (prev + routeA sec) (log ++ [A])) (chooseRouteLog B restNet (prev + routeA sec + cross sec) (log ++ [A,C]))
              B -> minWithLog (chooseRouteLog B restNet (prev + routeB sec) (log ++ [B])) (chooseRouteLog A restNet (prev + routeB sec + cross sec) (log ++ [B,C]))

minWithLog :: (Num a, Ord a) => (a, [Route]) -> (a, [Route]) -> (a, [Route])
minWithLog a b
    | fst a < fst b = a
    | otherwise = b