intercalar :: a -> [a] -> [[a]]
intercalar x [] = [[x]]
intercalar x ys = (ys ++ [x]) : [i ++ [last ys] | i <- intercalar x (init ys)]