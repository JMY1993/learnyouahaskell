main = interact $ show . isPalindrome

noMoreThan :: Int -> String -> String
noMoreThan x str =
  let l = lines str
      shortLines = filter (\a -> length a <= x) l
      result = unlines shortLines
   in result

respondPalindromes contents = unlines $ map (\content -> if isPalindrome content then "palindrome" else "not a palindrome") (lines contents)

isPalindrome xs = xs == reverse xs