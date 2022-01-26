mymerge :: Ord a => [a] -> [a] -> [a]
mymerge xs [] = xs
mymerge [] ys = ys
mymerge xs ys | x < y = x : mymerge (tail xs) ys
              | otherwise = y : mymerge xs (tail ys)
              where x = head xs
                    y = head ys

metades :: Ord a => [a] -> ([a],[a])
metades x = splitAt (length x `div` 2) x

mymsort :: Ord a => [a] -> [a]
mymsort [] = []
mymsort [x] = [x]
mymsort x = mymerge (mymsort y1) (mymsort y2)
            where (y1,y2) = metades x