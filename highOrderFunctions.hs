zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
{-at first, I came up with this implementation, but it failed
zipWith' f xs ys = [f x y | x <- xs, y <- ys]
                     ^ will apply every possible pairs of x and y
                     which means redundancy
-}
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = f x y:zipWith' f xs ys