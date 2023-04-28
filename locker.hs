import qualified Data.Map as Map
{-
task:  a high-school has lockers so that students have some place to put their Guns'n'Roses posters. Each 
locker has a code combination. When a student wants a new locker, they tell the locker supervisor which 
locker number they want and he gives them the code. However, if someone is already using that locker, he 
can't tell them the code for the locker and they have to pick a different one. We'll use a map from Data.
Map to represent the lockers. It'll map from locker numbers to a pair of whether the locker is in use or 
not and the locker code.
-}

data LockerState = Free | Taken deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String String
lockerLookup n lmap =
    case Map.lookup n lmap of
        Nothing -> Left ("The locker: " ++ show n ++ " doesn't exist!")
        Just (s, c) -> case s of
            Taken -> Left ("The locker: " ++ show n ++ " has already been taken!")
            Free -> Right c

-- test data:
lockers::LockerMap
lockers =  Map.fromList   
    [(100,(Taken,"ZD39I"))  
    ,(101,(Free,"JAH3I"))  
    ,(103,(Free,"IQSA9"))  
    ,(105,(Free,"QOTSA"))  
    ,(109,(Taken,"893JJ"))  
    ,(110,(Taken,"99292"))  
    ]  