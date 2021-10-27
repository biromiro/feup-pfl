mediana :: Ord a => a -> a -> a -> a

mediana x y z | (x <= y && x >= z) || (x >= y && x <= z) = x
              | (y <= x && y >= z) || (y >= x && y <= z) = y
              | otherwise = z

mediana1 :: (Ord a, Num a) => a -> a -> a -> a
mediana1 x y z = (x + y + z) - max x (max y z) - min x (min y z)
