primos :: [Int]
primos = crivo [2 ..]

crivo :: [Int] -> [Int]
crivo (p : xs) = p : crivo [x | x <- xs, x `mod` p /= 0]

fatores :: Int -> [Int]
fatores 1 = []
fatores n = primo : fatores (n `div` primo)
  where
    primo = head (filter (\p -> n `mod` p == 0) primos)