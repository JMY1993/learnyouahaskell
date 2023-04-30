-- unit 8 Making Our Own Types and Typeclasses
module Shapes
  ( Point (..),
    Shape (..),
    surface,
    nudge,
    baseCircle,
    baseRect,
  )
where

import Data.Map qualified as Map

{-
Question:
what is a data type, value constructor, typeclass
\* data: is a symbol that denotes the name after it is a type
\* value constructor: is what goes after the equal sign in a data declaration, which indicates a value of that
type
    - if it's not followed by a few parameters, it is an enum vlaue
    - otherwise it is a constructor with a few parameters, which can be pattern matched against
\* typeclass: is the type of type, which is dervied (if declared so) when a type is declared
\* value constructors are just functions taking the fields as parameters and returning values of a type
-}
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

data Point = Point Float Float deriving (Show)

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = abs (x2 - x1) * abs (y2 - y1)

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x + a) (y + b)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2 + b))

baseCircle :: Float -> Shape
baseCircle = Circle (Point 0 0)

baseRect :: Float -> Float -> Shape
baseRect w h = Rectangle (Point 0 0) (Point w h)

-- using record syntax
data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

{-
Question:
what is a type constructor:
- we have two kinds of constructors regarding type declaration for now:
  1. the value constructor, which goes after the equal sign (=), it shows basically how we init a
     value with fields. We can use the record syntax to make it more readable and hence utilize
     the syntax suger that GHC will automatically generates a getter function for each field
  2. the type constructor, which stays before the equal sign (=), it take parameters that are types
     which could be used on the other side of the equal sign(inside the value construction expression)
     if we have a type constructor, say, "Maybe". There will not be a type that is just "Maybe". If we
     declare a type `data Maybe a = Nothing | Just a` and have a value of `Just 100`, we've got a
     "Maybe Int" type. If we've got a value that is just "Nothing", it type is "Maybe a". You will never
     get a value of just "Maybe" (it's not a type per se, it's just a constructor).
-}

data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i * m) (j * m) (k * m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i * l + j * m + k * n

{-
Question：
When are we in Haskell's type portion?
1. whenever we're defining new types (so in data and type declarations)
2. after a `::` symbol (namely in type delcarations, when we explicitly declare a function's type or in type
   annotations)
-}

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
  case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
    Just (state, code) ->
      if state /= Taken
        then Right code
        else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"

lockers :: LockerMap
lockers =
  Map.fromList
    [ (100, (Taken, "ZD39I")),
      (101, (Free, "JAH3I")),
      (103, (Free, "IQSA9")),
      (105, (Free, "QOTSA")),
      (109, (Taken, "893JJ")),
      (110, (Taken, "99292"))
    ]