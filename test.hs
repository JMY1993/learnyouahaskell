-- this is not allowed

testCase :: (Eq t1, Num t1, Num t2) => t1 -> t2 -> t2
testCase a b = case (a, b) of
    (0, _) -> 0
    (a, b) -> b + testCase (a-1) b

{-
this is just an implement of multiply
-}
test1 :: (Eq t1, Num t1, Num t2) => t1 -> t2 -> t2
test1 0 _ = 0
test1 a b = b + test1 (a-1) b

infixl 7 .*

a .* b = case (a, b) of
    (0, _) -> 0
    (a, b) -> b + ((a-1) .* b)