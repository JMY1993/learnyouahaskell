{-
how to understand typeclass Functor:
firstly, all Functor typeclasses has a kind of "* -> *", which means that its kind is that it takes a concrete type to form another concrete type.
With this in mind, we find that (Maybe) is instance of Functor, since Maybe isn't concrete but "Maybe a" is. (here a means that we don't know what exactly is the concrete type
, but that doesn't jeopardize that fact that it is. What the exact type is would not be the focus at the level of `:kind`. You can consider it as a wildcard)

Secondly we should think about what those instances stand for:

lists is instance of Functor. [a] stands for a few values that have the type of `a`, packed in a []
Maybe a is instance of Functor, it stands for a value that has the type of `a`, packed in a box called `Maybe`

For functions we need to think a little more carefully, for each function that has a type of a -> b, which is just the type of the function.
We can rewrite it as "(->) a b", we can mentally think of it as the way we think of `Either` that if `Either a b` means that Either takes two type parameters. Meaning that `a` is
a type and `b` is also a type, in order to consititue an Either value, we should specify the two types inside it. So Either has a kind of * -> * -> *，meaning that Either take two
concrete type and produces one concrete type.
While -> also has a kind of * -> * -> *, because both left and right side of the sign `->` are values whose type must be concrete to generate a concrete type. Lets take function
(\x -> x + 1) and (\y -> toUpper y) as examples, the former has type declaration ((Num a) => a -> a) while the later has (Char -> Char). Let's assume that functions are declared as

data Func a = ..., the former one's type is ((Num a) => Func a), the latter one's is (Func Char). But unlike any other type constructors who always have fixed number of type parameters,
Func may have different numbers of type parameters. Say we have a function (\x -> foldl (+) 0 x)

"(->) a b" means that (->) takes two type parameters. So if `Either a` is instance of Functor, `(->) a` shall also constitute an instance of Functor.
Let's take (subtract 3) as an example, it has a type of (Sum a) => a -> a, if when apply any number to the funtion (like 4), it will have a type of 
`(Num a) => (->) a`

-}