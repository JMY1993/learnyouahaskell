main = interact respondPalindromes

noMoreThan :: Int -> String -> String
noMoreThan x str =
  let l = lines str
      shortLines = filter (\a -> length a <= x) l
      result = unlines shortLines
   in result


{-
the `interact` function takes a String -> String function and returns an IO action, which returns a `IO ()` type

the IO action takes some input and run the funtion (which we passed earlier) on it, and then print out the
funtion's result.

it will take the entire bunch of your input not just a line.

to test this, we firstly define a function called isPalindrome, which tests whether the string as its argument is a
palindrome and returns true if it is and false if not.

we hence have the following code:

main = interact $ show . isPalindrome

we run the code and notice that no matter how many lines we input, we will only get one output after we get out of the
input state with Ctrl-C, which denotes that there may be something like `getContents` inside `interact` 

but if we change the function from isPalindrome to respondPalindromes, something strange happens:

it is supposed to handle a big string of input, but it acts like it processes the string line by line.

main = interact respondPalindromes

why is it so?
TODO:
-}
respondPalindromes :: String -> String
respondPalindromes contents = unlines $ map (\content -> if isPalindrome content then "palindrome" else "not a palindrome") (lines contents)

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = xs == reverse xs