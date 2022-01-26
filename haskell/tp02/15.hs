intersperse :: a -> [a] -> [a]
intersperse x [] = []
intersperse x [y] = [y]
intersperse x (y:ys) = y : x : intersperse x ys