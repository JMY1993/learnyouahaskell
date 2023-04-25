module Shapes
  ( Point (..),
    Shape (..),
    surface,
    nudge,
    baseCircle,
    baseRect,
  )
where

{-
what is a data type, value constructor, typeclass
\* data: is a symbol that denotes the name after it is a type
\* value constructor: is what goes after the equal sign in a data declaration, which indicates a value of that
type
    - if it's not followed by a few parameters, it is an enum vlaue
    - otherwise it is a constructor with a few parameters, which can be pattern matched against
\* typeclass: is the type of type, which is dervied (if declared so) when a type is declared
* value constructors are just functions taking the fields as parameters and returning values of a type
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