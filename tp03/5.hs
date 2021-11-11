mymaximum, myminimum :: Ord a => [a] -> a

mymaximum = foldl1 (\x y -> if x > y then x else y)
myminimum = foldr1 (\x y -> if x < y then x else y)

myfoldl1 :: (a -> a -> a) -> [a] -> a
myfoldl1 f x = foldl f (head x) (tail x)

myfoldr1 :: (a -> a -> a) -> [a] -> a
myfoldr1 f x = foldr f (last x) (init x)