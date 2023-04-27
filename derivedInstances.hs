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
Bounded: things that have a lowest possible value and highest
Show: Show typeclass is for things that can be converted to strings
Read: it's kind of the reverse process of Show, which converts from a string to a value 
-}