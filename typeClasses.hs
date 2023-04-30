import MyModules.BinarySearchTree (Tree (EmptyTree, Node), treeFromList)
{-
in this code file, we will dive into type classes, on
1. how they are defined
2. how to instantiate a typeclass (how many ways to do this)
3. how to define typeclass and it's functions
4. what is a concrete type
5. what is a functor
-}

-- firstly define a Eq type class
class Equal a where
  (.==) :: a -> a -> Bool
  (./=) :: a -> a -> Bool
  (.==) a b = not (a ./= b)
  (./=) a b = not (a .== b)

data TrafficLight = Red | Yellow | Blue

instance Equal TrafficLight where
  Red .== Red = True
  Yellow .== Yellow = True
  Blue .== Blue = True
  _ .== _ = False

instance Show TrafficLight where
  show Red = "Red Light"
  show Yellow = "Yellow Light"
  show Blue = "Blue Light"

{-
class (Eq a) => Num a where
        ^ this is a class constraint
-}

instance Equal m => Equal (Maybe m) where
  Just x .== Just y = x .== y
  Nothing .== Nothing = True
  _ .== _ = False

{-
question: what does ":info" directive work for:
1. type classes, showing the functions defined and the types derive it
2. types
3. type constructors
4. type declaration of a function
-}

{-
question: describe the keywords hierarchy of haskell
TODO:
-}

{-
try to implement the JavaScript-ish behavior to consider values other than boolean as truthy or falsy

falsy
0
""
[]
-}

class YesNo a where
    yesno :: a -> Bool

instance YesNo Int where
    yesno 0 = False
    yesno _ = True

instance YesNo [a] where
    yesno [] = False
    yesno _ = True

instance YesNo Bool where
    yesno = id

instance YesNo (Maybe a) where
    yesno Nothing = False
    yesno _ = True

instance YesNo (Tree a) where
    yesno EmptyTree = False
    yesno _ = True

instance YesNo TrafficLight where
    yesno Red = False
    yesno _ = True