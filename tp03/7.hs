myplusplus :: [a] -> [a] -> [a]
myplusplus x y = foldr (:) y x

myconcat :: [[a]] -> [a]
myconcat = foldr myplusplus []

myreverse :: [a] -> [a]
myreverse = foldr (\x y -> y ++ [x]) []

myreverse2 :: [a] -> [a]
myreverse2 = foldl (flip (:)) []

myelem :: Eq a => a -> [a] -> Bool
myelem x = any (==x)