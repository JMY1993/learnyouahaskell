{-
let's explorer how fold acts and how it is related to recursive process
-}



{-
this is how foldr is possibly implemented:

f1::String -> String
f1 [] = []
f1 (x:xs) = x:f1 xs

f2::String -> String
f2 = foldr (:) []
-}

{-
f3::String -> String
f3 [] = []
f3 list = f3 (init list) ++ [last list]

-- (((([] ++ [x1]) ++ [x2] ) ++ [x3] ) ++ [x4] ) ++ [x5]
-}