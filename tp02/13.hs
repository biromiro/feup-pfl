mindiv :: Int -> Int
mindiv 0 = 0
mindiv 1 = 1
mindiv x | null z = x 
         | otherwise = head z
         where z = [ y | y <- [2..(floor . sqrt . fromIntegral) x], x `mod` y == 0]

primo :: Int -> Bool
primo x | x <= 1 = False 
        | otherwise = mindiv x == x