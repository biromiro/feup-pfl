fromBits :: [Int] -> Int 
fromBits x = sum (zipWith (*) x (reverse (take (length x) (iterate (*2) 1))))