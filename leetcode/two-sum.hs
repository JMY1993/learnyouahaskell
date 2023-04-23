{-
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

-- how it works:
let's assume that the head of the list is the first number, we need a function
called "findNext" to find the next number from the tail of the list, we are doing
it this way:
if the first number of the tail of the list is the right number (which added up to the target with the chosen first number)
then we return it as the result
if not, we find the next number from the tail of the tail of the list, until we
test out all of the numbers and found nothing, where we would return a -1

if we find the next number successfully, we return a tuple of their indexes
while if we aren't so lucky, we shall assume the first element of the tail
is the first number, and try to find the next number from the tail of the tail
and we do the above recursively, we call this procedure "findFirst", which can
also be extracted as a function
-}

findNext :: (Num i, Ord i) => i -> i -> i -> [i] -> i
findNext _ _ _ [] = -1
findNext target firstI firstV (x : xs)
  | target == firstV + x = firstI + 1
  | otherwise = findNext target (firstI + 1) firstV xs

findFirst :: (Num i, Ord i) => i -> i -> [i] -> (i, i)
findFirst target firstI (x : xs)
  | nextI >= 0 = (firstI, nextI)
  | otherwise = findFirst target (firstI + 1) xs
  where
    nextI = findNext target firstI x xs

twoSum :: (Num i, Ord i) => i -> [i] -> (i, i)
twoSum target = findFirst target 0

-- lets make a compact version

-- twoSum' :: (Num i, Ord i) => i -> [i] -> (i, i)
twoSum' :: Int -> [Int] -> (Int, Int)
twoSum' target = testFirst' 0
  where
    -- testFirst' :: (Num i, Ord i) => i -> [i] -> (i, i)
    testFirst' :: Int -> [Int] -> (Int, Int)
    testFirst' firstI (x : xs)
      | nextI >= 0 = (firstI, nextI)
      | otherwise = testFirst' (firstI + 1) xs
      where
        nextI = findNext' firstI x xs
        -- findNext' :: (Num i, Ord i) => i -> i -> [i] -> i
        findNext' :: Int -> Int -> [Int] -> Int
        findNext' _ _ [] = -1
        findNext' firstI firstV (x : xs)
          | target == firstV + x = firstI + 1
          --            ^ error
          -- 如果把type declaration改成现在这个样子会报错：
          -- firstV定义在findNext'中，而target定义在twoSum’中，findNext'的函数获得了定义在上层
          -- clause里定义的type class类的target(Num i, Ord i)，编译器无法确定这两种类型相等，没有办法进行运算
          | otherwise = findNext' (firstI + 1) firstV xs