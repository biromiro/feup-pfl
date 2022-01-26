f1 :: Num a => a -> a
f1 x = x * 2

p :: (Num a, Ord a) => a -> Bool
p x = x < 5

nocompr :: [a] -> (a -> a) -> (a -> Bool) -> [a]
nocompr xs f p = map f (filter p xs)

withcompr :: [a] -> (a -> a) -> (a -> Bool) -> [a]
withcompr xs f p = [f x | x <- xs, p x]