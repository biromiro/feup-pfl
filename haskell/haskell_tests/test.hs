transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [[(m !! i) !! i1|  i <- [0..length m - 1]] | i1 <- [0..length (m !! 0)- 1]]

sumWrapped :: Matriz -> Vector
sumWrapped x = [sum y | y <- x]

divToMatriz :: Vector -> Int -> Matriz
divToMatriz [] _ = []
divToMatriz lst len = (take len lst) : divToMatriz (drop len lst) len

prodMatAux :: Matriz -> Matriz -> Matriz
prodMatAux m1 m2 = divToMatriz (sumWrapped [k | x <- m1, y <- transposta m2, k <- [zipWith (*) x y]]) (length (m2 !! 0))

prodMat :: Matriz -> Matriz -> Matriz
prodMat _ [] = []
prodMat [] _ = []
prodMat m1 m2 | length (m1 !! 0) /= length m2 = error "Impossible product."
              | otherwise = prodMatAux m1 m2