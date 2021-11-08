aprox :: Int -> Double
aprox n = sum [(fromIntegral (-1)^c) / fromIntegral (2*c + 1) | c <- [0..n]] * 4

aprox' :: Int -> Double 
aprox' n = sqrt(sum [(fromIntegral (-1)^c) / fromIntegral ((c+1)^2) | c <- [0..n]] * 12)