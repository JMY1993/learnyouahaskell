{-
Below is my understanding of monad especially funtion as monad.

monad is beefed-up applicative, which is beefed-up functor, which encapsulates a value in a computation.

when you see some thing like `f a`, it means that a is a value with some type, and the type shall be part of typeclass f. Take (Num a) as an example, here `f` is `Num`

Now let's talk about Maybe type class. When you see something like:

(>>=) :: m a -> (a -> m b) -> m b
if the function (>>=) is designed solely for Maybe, it would be:
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b

So what are Maybe values looks like? We have Nothing and Just a. For example, Just 10 is a Just Int value.

Now let's talk about function as Monad. We have a type `(->) r`, so what the hack?
lets be clear that (->) is a type constructor not a value constructor, therefore (->) r means that type constructor (->) has ready partially applied to its first 
parameter. Just like type class Maybe has two ways to construct its value, (->) has many, each of which is basically done with the type constructor (->). Here pay
attention that (->) is also a type constructor. In Haskell, we can use a syntactic sugar:

power5 x = x * x * x * x * x

it is actually: 
power5 = \x -> x * x * x * x * x

here, power5 is actually a value constructor for type `(->) r`, just like 

We should be aware that `(->) r` is a type signature, which is shown in a type area. When we see `Either a b`, we know that to have a concrete type from Either, we have to provide two additional 
types a and b. For example, `Either String Int`, it has a kind of `*` (if a and b are not specifed, it shall be `* -> * -> *`). The same goes to `(->) r`. When we see (->) in a type area, we know 
that we need two additional types a and b. For example, `(Num a, Eq a) => a -> a`, it has a kind of `*` (if a and b are not specifed, it shall be `* -> * -> *`).

Now let's take a look at what will be the value constructors following the above type signatures:

For Maybe, since it's kind is `* -> *`, we need to provide with one concrete type for it to form a concrete type, so `Just "happy"` is a value and Just is a value constructor, it's type is `Just String. 
We say that Maybe is instance of Monad, which takes a concrete type. When we see the type signature like:  
(>>=) :: m a -> (a -> m b) -> m b
if the function (>>=) is designed solely for Maybe, it would be:
(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b

For [], since it's kind is `* -> *`, we need to provide with one concrete type for it to form a concrete type, so `"happy"` is a value and [] is a value constructor`, it's type is [Char].
We say that [] is instance of Monad, which takes a concrete type. When we see the type signature like:  
(>>=) :: m a -> (a -> m b) -> m b
if the function (>>=) is designed solely for [], it would be:
(>>=) :: [a] -> (a -> [b]) -> [b]

For Either, since it's kind is `* -> * -> *`, we need to provide with it another type so that it could be `Either a` where type a is fixed. 

The same to `(->)`, it's kind is also `* -> * -> *`. If `Int` is a concrete type and `String` is a concrete type, then `Int -> String` is also a concrete type.

The right way to think of Functor, Applicative and Monad is not to mentally pattern match them. We need to think more regarding the definition, that is:
1. a Functor is a value encapsulated in a computation.
    Maybe denotes that there may and may not be a value. The value inside Maybe could be `taken out` by pattern matching, this is just the feature of Maybe, not a feature of every Monad.

    `Either a b` denotes that there may be value of the type a or value of type b, it encapsulates a value that is either of the type a or b. So `Either a` is a type that is part of class Functor.
    Do not think of `Either a` as a type of value b is encapsulated in anology to `Maybe`, since `Maybe` dosen't represent a value of type a encapsulated. `Either a` still represents a value of 
    type a or b, it's just when we apply different functions to it, like fmap, <*>, >>=, >>, it's first parameter is ommited. But this ommition isn't brought by the programming language, it's by
    people who implement the funtions, which means you can also change the value of the first parameter if you want and the functions may disabay the laws of those type classes. So grammarly, the 
    language only put a limitation on the type, a.k.a if you want a type to be instance of Functor, Applicative or Monad, it's kind should be `* -> *`.

    `(->) a b` denotes a computation when given value of type a as input will produce a value of type b as result. `(->) a` doesn't mean that the first parameter of the function is already fixed or
    the first parameter's type is defined, it's not that way. Think of `(->) a`as:

    a) `(->) a` is a computation that is about to give a value, what the value exactly is may have something to do with its first parameter, but what the functions we will apply to is the result, 
    which is `b`, the second parameter of `(->)`

    b) we write `instance Monad ((->) r)` in just a type area, in other words `(->) a` is just a type constructor, don't confuse it with a value constructor. We write `(->) r` here just to represent
    a function that takes only one parameter and produces a value

    c) don't think that since `(->) a` means that a is defined then the type of `b` which is its result isn't defined. Firstly, to have a function, it's parameter's and result's types should all be
    defined in advance. Secondly, you should mentally distinguish things in three different layers:
    
    layer one: kind, it describes whether a type is concrete or need another concrete type to make a concrete type. 
    
    Int => * , because Int is a datatype
    Num => * -> constraint, because you need to write (Num a) to denote that a is imposed constraint to support functions pre-defined in class Num.
    Maybe => * -> *, because you need to write `Maybe a` to refer to a concrete value (need another type a)
    Either => * -> * -> *, because you need to write `Either a b` to refer to a concrete value (need another two types a and b)
    Either a => * -> *, because you need to write `Either a b` to refer to a concrete value (need another one type b)
    (->) => * -> * -> *, because you need to write `a -> b` to refer to a concrete value (need another two types a and b)
    (->) a => * -> *, the same as above
    Monad => (* -> *) -> constraint, because you have to 

    in this layer, * represents a concrete type. We only work on types, type constructors and constraints. We only use * (star), -> (arrow) and `constraint` to describe the kind of a type.

    layer two: type.
    We use:
        type constructors, like Either, Tree, [], Maybe
        type constructors apples to type parameters, like Either a b, Tree a, Maybe a
        type constrains, like (Num a) => a -> b
        type names, like `Either String Tree`,(String and Tree are type names)
        value constructors, like `Either String Tree`, (Either is a value constructor)

    layer three: expression
    in this layer, we do calculations using functions, values, synmbols, value constructors
-}