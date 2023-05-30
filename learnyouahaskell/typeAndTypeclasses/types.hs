-- learnyouahaskell unit 3 Types and Typeclasses

-- 如果不加显性类型声明（explicit type declaration），会显示：factorial :: (Num a, Enum a) => a -> a
factorial :: Integer -> Integer
factorial n = product [1..n]

{-
如果不用explicit type declaration，ghc自动推断为 Floating a => a -> a
并且 计算结果为 25.132741228718345 而不是 25.132742，后者是进行了显示类型声明后的结果
自动推断的是Double，显式后是Float
-}

circumference :: Float -> Float
circumference r = 2 * pi * r

{-
whole numbers are polymorphic constants:

ghci> 5 + 5.1
10.1

error 1: No instance for (Fractional Int) arising from the literal ‘3.2’
ghci> (length [1,2,3,4]) + 3.2
        ^ Int               ^Fractional

since 3.2 is the constant, so the compiler thought it shall be the one to accommodate
ghci> fromIntegral (length [1,2,3,4]) + 3.2
7.2

the above code works well

error 2: Couldn't match expected type ‘Int’ with actual type ‘Integer’
ghci> (5::Int) * (6::Integer)

ghci> (fromIntegral (5::Int)) * (6::Integer)
ghci> (5::Int) * fromIntegral (6::Integer) 

the above two pieces of code work well

error 3: 


the compiler knows that the number 5 shall be a Floating class of type



-}

