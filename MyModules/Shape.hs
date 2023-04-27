module MyModules.Shapes
  ( Point (..),
    Shape (..),
    baseCircle,
    baseRectangle,
    nudge,
    surface,
    perimeter,
  )
where

{-
practice 1:
build a shape type system of your own. It should handle circles and rectangles, you are also to implement
functions to calc the perimeters and areas
-}
data Point = Point {coordinateX :: Float, coordinateY :: Float} deriving (Show)

data Shape = Circle {pointC :: Point, radius :: Float} | Rectangle {pointUpperLeft :: Point, pointLowerRight :: Point} deriving (Show)

baseCircle :: Float -> Shape
baseCircle = Circle (Point 0 0)

baseRectangle :: Float -> Float -> Shape
baseRectangle width height = Rectangle (Point 0 0) (Point width height)

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) xOffset yOffset = Circle (Point (x + xOffset) (y + yOffset)) r
nudge (Rectangle (Point x1 y1) (Point x2 y2)) xOffset yOffset = Rectangle (Point (x1 + xOffset) (y1 + yOffset)) (Point (x2 + xOffset) (y2 + yOffset))

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = abs (x1 - x2) * abs (y1 - y2)

perimeter :: Shape -> Float
perimeter (Circle _ r) = pi * r * 2
perimeter (Rectangle (Point x1 y1) (Point x2 y2)) = abs (x1 - x2) + abs (y1 - y2)