myand :: [Bool] -> Bool
myand = foldr (&&) True

myor :: [Bool] -> Bool 
myor = foldr (||) False

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs

myreplicate :: Int -> a -> [a]
myreplicate 0 x = []
myreplicate k x = x : myreplicate (k-1) x

mybangbang :: [a] -> Int -> a
mybangbang x 0 = head x
mybangbang x y = mybangbang (tail x) (y-1)

myelem :: Eq a => a -> [a] -> Bool
myelem x [] = False
myelem x (y:ys) = x == y || myelem x ys