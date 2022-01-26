addPoly :: [Int] -> [Int] -> [Int]
addPoly x y | length x == length y = zipWith (+) x y
            | length x < length y = zipWith (+) (take (length y - length x) (iterate (*1) 0) ++ x) y
            | otherwise = zipWith (+) x (take (length y - length x) (iterate (*1) 0)) ++ y

--multPoly :: [Int] -> [Int] -> [Int]
