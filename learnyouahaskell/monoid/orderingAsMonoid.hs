lengthCompare :: String -> String -> Ordering
lengthCompare x y = (length x `compare` length y) `mappend`
                    (vowels x `compare` vowels y) `mappend`
                    (x `compareTrivial` y)

    where compareTrivial x y = mconcat $ zipWith compare x y
          vowels = length . filter (`elem` "aeiouAEIOU")

{-
make a function that takes 1) a series of compare functions in the order of importance and 2) two values

the function will compare with respect of all the criterions

-}

compareWithConds :: [a -> b -> Ordering] -> a -> b -> Ordering
compareWithConds conds a b = mconcat $ map (($ b) . ($ a)) conds

compareTheir :: Ord a => [t -> a] -> t -> t -> Ordering
compareTheir transforms = compareWithConds (map (\ trans a b -> trans a `compare` trans b) transforms)

{-
pay attention to the type signature of compareTheir, we see Ord a => [t -> a] -> t -> t -> Ordering

so if you implement lengthCompare' this way:

lengthCompare' = compareTheir [length, vowels, id], it won't pass compiler

since all elements in the transformer lists should has the same resulting value, which is stated in the [t -> a] part.

-}
lengthCompare' :: String -> String -> Ordering
lengthCompare' = compareTheir [length, vowels] `mappend` compareTheir [id]
    where vowels = length . filter (`elem` "aeiouAEIOU")