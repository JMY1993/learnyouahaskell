-- for the following function, ghci evaluation stucks when n is greater than 50 
fib :: (Eq t, Num t) => t -> t
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- for the following function, ghci can evaluate up to a 6-digit number
fibIter :: (Eq t, Num t) => t -> t -> t -> t
fibIter a b 0 = b
fibIter a b n = fibIter b (a + b) (n - 1)

fibI = fibIter 0 1