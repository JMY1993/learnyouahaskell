-- learnyouahaskell unit1
doubleMe x = x + x
doubleUs x y = x*2 + y*2
doubleSmallNumber x = if x > 100 then x else x*2
boomBangs xs = [if x > 10 then "BANG!" else "BOOM!" | x <- xs, x `mod` 2 /= 0]
-- new length function
length' xs = sum [1 | _ <- xs]
-- this version uses a function that takes one arg but always returns a number 1
-- notice that the x must exist other wise it cannot be used as the first arg of map
return1 x = 1
length'' xs = sum (map return1 xs)

-- romove all the non-uppercase
removeNonUpperCase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- nested list comprehension
takeAllEvens xxs = [[ x |x <- xs, even x]|xs <- xxs]

-- Here's a problem that combines tuples and list comprehensions:
-- which right triangle that has integers for all sides and all sides equal to or smaller
-- than 10 has a perimeter of 24?

-- this snippet of code stuck [(a,b,c)|a<-[1..], b<-[1..], c<-[1..], a<=10, b<=10, c<=10]

-- this snippet of code works, but it gives all combinations of sides
result1 = [(a,b,c)|a<-[1..10], b<-[1..10], c<-[1..10], a+b+c == 24, a*a+b*b==c*c || a*a+c*c==b*b || b*b+c*c==a*a]

-- this snippet of code gives the combination when b isn't larger than c and a isn't larger than b
    --note that the code as follows don't pass the compiler, it prompts that variable b and c no in scope
    --result2 = [(a,b,c)|a<-[1..b], b<-[1..c], c<-[1..10], a+b+c == 24, a^2 + b^2 == c^2]
    --                          ^          ^

result2 = [(a,b,c)|c<-[1..10], b<-[1..c], a<-[1..b], a+b+c == 24, a^2 + b^2 == c^2]
