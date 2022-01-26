calcPi1 :: Int -> Double
calcPi1 x = foldl (+) 0.0 (zipWith (\x y -> fromIntegral x / fromIntegral y) k t)
  where
    k = (replicate x 4)
    t = zipWith (*) (cycle [1, -1]) (take x [y | y <- [1 ..], y `mod` 2 == 1])

calcPi2 :: Int -> Double
calcPi2 x = foldl (+) 3.0 (zipWith (\x y -> fromIntegral x / fromIntegral y) k t)
  where
    k = (replicate x 4)
    t = zipWith (*) (cycle [1, -1]) (take x [y * (y + 1) * (y + 2) | y <- [2 ..], y `mod` 2 == 0])