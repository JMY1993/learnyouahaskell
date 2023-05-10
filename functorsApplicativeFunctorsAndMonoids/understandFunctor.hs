{-
how to understand typeclass Functor:
firstly, all Functor typeclasses has a kind of "* -> *", which means that its kind is that it takes a concrete type to form another concrete type.
With this in mind, we find that (Maybe) is instance of Functor, since Maybe isn't concrete but "Maybe a" is. (here a means that we don't know what exactly is the concrete type
, but that doesn't jeopardize that fact that it is. What the exact type is would not be the focus at the level of `:kind`. You can consider it as a wildcard)

Secondly we should think about what those instances stand for:

lists is instance of Functor. [a] stands for a few values that have the type of `a`, packed in a []
Maybe a is instance of Functor, it stands for a value that has the type of `a`, packed in a box called `Maybe`

For functions we need to think a little more carefully, for each function that has a type of a -> b,
We can rewrite it as "(->) a b", we can make anology to `Either` that if `Either a b` means that Either takes two type parameters, that `a` is a type and `b` is also a type, in order
to consititue an Either value, we should specify the two types inside it. So Either has a kind of * -> * -> *，meaning that Either takes two concrete types and produces one concrete 
type.
While -> also has a kind of * -> * -> *, because both left and right side of the sign `->` are values whose type must be concrete to generate a concrete type, and the concrete type
generated is Function. Let's imagine a function that has a type of `Int -> Char` is `(->) Int Char`, maybe we can make up a data type named Func and it will be `Func Int Char` which
represents a function that take an Int and produces a Char. So `Func Int` has a kind of * -> *, meaning that if we provide the type of the return value, we would have a concrete type.

So `Func Int` is an instance of Functor, and it encapsulates the type of its return value into the box. So fmap will make some change in some way to the type inside the box `Func Int`,
and make a new value with a new type. Say: Func Int Int -> Func Int Char

Lets take function
(\x -> x + 1) and (\y -> toUpper y) as examples, the former has type declaration ((Num a) => a -> a) while the later has (Char -> Char). 

The former one would be `(Num a) => Func a a`, now we do `fmap (\x -> read x) (\x -> x + 1)`, we've transformed the function type into `(Num a) => Func a Char`

Basically, when we do `fmap f (Sometype a)`, where type constructor Sometype will take two type parameters, we are actually modifying the type of the second parameter.
eg:
fmap f (Either a), is modifying the type of the right value, since it is defined as `data Either a b = Left a | Right b`
fmap f ((->) a), is modifying the type of the returning value, as we've discussed and analyzed above.

Why am I so confused about this and what stuck me here so long a time?

Let's take (Maybe Int) as an example. When you run `fmap show (Just 5)`, you get a (Just "6"). Which is pretty much like 6 is put into a box, and you are mapping function `show` over the
inside value. So you may deduce that if you have a function f, then you can do `fmap show (f 5)` and you will get a value of `f (show 5)`. No! it not working that way!

by doing (f 5), you are applying 5 as parameter to f, it will return some value which has the type that is already defined in the function declaration. If f = (\x -> x + 1), then (f 5) is
already 6, it's type is Int not something like `f int`. So does `Just 5`, it's type is `Maybe Int` not `Just Int`.

If you run `:t Just`, you get `Just :: a -> Maybe a`, so Just isn't a type, it's a value construtor or a function that returns a `Maybe a` type.

Besides, it's `f` itself alone should be fmaped over, not with its parameters. Since it f is called with it's parameters, they are already a concrete type other than a Functor, which by
definition shall ask for spesicficly only one type parameter.

And in addition, if we have a value:

testMaybe = Just 5, we can label it with it's type declaration `testMaybe :: Maybe Int`
                                                                                    ^ the Int is what to be fmaped over, since Maybe has a kind of * -> *

if we have a function:

testFunc x = x + 1, we can label it with `testFunc :: (->) Int Int`
                                                                ^ the second Int is what to be fmaped over, since `(->) Int` has a kind of * -> *
-}