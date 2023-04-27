{-
question: what are the most commonly used typeclasses we've already met for now?
And what are their charactristics?
Eq: types deriving Eq can be tested of their equality
    can be compared with operator `==` or `/=`
Ord: types deriving Ord can be ordered.
    can be compared with function `compare`, which will return either of the three Ordering values:
    GT, LT, EQ
    if two values of the same type are compared with `compare`, the one whose value constructor was defined
    in advance is considered smaller
Enum: for things that have predecessors and successors (the value constructors are nully ---- have no parameters)
      we have functions for Enum typeclass: the `succ` function which returns the next value, and the `pred` function
      which returns the previous one
Bounded: things that have a lowest possible value and highest
        we have two special values called minBound and maxBound
Show: Show typeclass is for things that can be converted to strings
Read: it's kind of the reverse process of Show, which converts from a string to a value 
-}

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday deriving (Eq, Ord, Enum, Bounded, Show, Read)