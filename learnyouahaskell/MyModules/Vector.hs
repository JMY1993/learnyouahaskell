module MyModules.Vector
  ( Vector (..),
    vplus,
    vectMult,
    scalarMult,
  )
where

data Vector a = Vector a a a deriving (Show)

vplus :: Num a => Vector a -> Vector a -> Vector a
(Vector a b c) `vplus` (Vector d e f) = Vector (a + d) (b + e) (c + f)

vectMult :: Num a => Vector a -> a -> Vector a
(Vector a b c) `vectMult` m = Vector (a * m) (b * m) (c * m)

scalarMult :: Num a => Vector a -> Vector a -> a
(Vector a b c) `scalarMult` (Vector d e f) = a * d + b * e + c * f