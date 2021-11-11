toBits :: Int -> [Int]
toBits 0 = [0]
toBits 1 = [1]
toBits x = toBits (x `div` 2) ++ [y]
         where y = x `mod` 2