myminimum :: Ord a => [a] -> a
--myminimum [] = 0
myminimum (x:xs) | null xs = x
                 | y < x = y
                 | otherwise = x
                 where y = myminimum xs

mydelete :: Eq a => a -> [a] -> [a]
mydelete x (y:ys) | x == y = ys
                  | otherwise = y : mydelete x ys

myssort :: Ord a => [a] -> [a]
myssort [] = []
myssort x = y : myssort (mydelete y x)
           where y = myminimum x