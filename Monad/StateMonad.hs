module Monad.StateMonad(State'(..)) where
{-
below is my understanding of Stateful monad

--
question1: what is a stateful computation

1. firstly, a stateful computation shall be a computation firstly, which is a monad

2. secondly, a stateful computation shall be accompanied with state

we can conclude from it, that a stateful computation has a value encapsulatated, and it the value is worked out (computed) there should be a state that follow

--
question2: a stateful computation is defined as s -> (a, s), which is totally reasonable according to our understanding of stateful computation. However, if we just do the pair and it also
    fits the definition of Monad, let's take (s, a) as an example, why isn't it a stateful computation?

if we do `newtype State s a = (s, a)`, then it's true that `State s` is definitely a Monad. But State under this definition is lack of expressiveness, since the computation how a is taken
out is just `snd`.

in addition, if we pay attention to the type signature of `>>=` , it is `(>>=) :: m a -> (a -> m b) -> m b`, meaning if we write `m >>= f`, f only takes the result of the previous computation
other than the state of the previous computation. Based on our experience with other monadic values, how the computational context change is defined in the implementation of `>>=`, for example,

in `Maybe`, whether the previous computation results in a Nothing is propagated all the way through;
in `[]`, a set of values with is not determined will be treated as if we have already choosen one value, and input that value to the next round (non-determinism)
in `Writer`, we've put a log system with our code, which will log information as requested and append those info
in `Reader`, we are regarding functions that takes only one parameter as a Monad value which has a result to be worked out. We are able to put a series of Readers together and treat them as
values as if we've already have them evaluated, do something with those imaginary values.

as we've deduced from the above 4 examples, the computional context is predefined of their actual meaning and how to preserve the context also predefined, which you are not supposed to define
case by case.

Let's get back to stateful computation, the most obvious reason why (s, a) isn't qualified is that (s, a) acts more like a `Writer`, where nextround functions takes the results other than
the states. What if we make it (a, s)? It doesn't work either. We can of course make s as the input for nextround functions, but the result which is `a` becomes very unexpressive.

Now we have the expression on Monad values:
1. that the nextround functions takes only the value encapsulated as the input
2. how the computational context is preserved is predefined when we implement functions when make our type instance of Monad

that is, how we map over the encapsulated value is case by case (since we will write tons of `f`s), but how the computational context got preserved is sort of unified.

Now let's go back to the Stateful Computation:
1. by nature, a stateful computation takes state as input and generates value, so `s` must be part of the input value
2. we still want the value to be case by case. Since both `s` and `a` are case by case, the mapping should also be case by case
So we are mappting over states to values, and it's the mapping itself being the input (function as Monad)
Now we can deduce `Newtype s a = State {runState :: s -> (a, s)}`

the `f` of (>>=) has a type of `(>>=) :: m a -> (a -> m b) -> m b

-}

{-let's try to implement State-}

newtype State' s a = State' {runState' :: s -> (a, s)}

instance Functor (State' s) where
    fmap f (State' h) = State' (\s -> let (a, s') = h s in (f a, s')) 

instance Applicative (State' s) where
    pure x = State' (x, )
    State' g <*> State' f = State' (\s -> 
        let (a, s') = f s
            (f', s'') = g s'
            in (f' a, s''))

instance Monad (State' s) where

  return = pure

  State' h >>= f = State' (\s ->
    let (a, s') = h s
        State' g = f a
    in g s')