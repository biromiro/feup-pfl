mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub (x:xs) = [x] ++ mynub (filter (\a -> a /= x) (xs))