dotprod :: [Float] -> [Float] -> Float

dotprod x y = sum (map (\(x,y) -> x * y) (zip x y))