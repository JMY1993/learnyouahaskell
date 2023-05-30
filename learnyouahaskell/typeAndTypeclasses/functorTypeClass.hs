class Functor f where
    fmap :: (a -> b) -> f a -> f b

{-
question: what is the type of value that is part of the typeclass Functor?

it is a type constructor, not a value constructor

a type constructor takes a parameter (or more) of a type, it forms a concrete type
    Maybe Int
a value constructor takes a parameter of a value, it forms a specific value
    Just 30
a declaration of instance Functor takes a type constructor (without the parameter 
of the type constructor itself). It shall not form a concrete type
    instance Functor [] where -- this is ok
    instance Functor [a] where -- isn't ok, since [a] is already concrete

Functor typeclass is for things that can me mapped over
-}

{-
question: what is the kind system in Haskell?

In haskell, "kind" is the type of types.

When you write: :k [Type Constructor / Type], you will get response like:
* -> *
Or
*

the start sign refers to a concrete type, so * -> * refers to a type constructor which 
takes one concrete type and produces another concrete type

any functor should be of the kind of * -> *

-}