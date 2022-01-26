myconcat :: [[a]] -> [a]
myconcat xss = [x | xs <- xss, x <- xs]

myreplicate :: Int -> a -> [a]
myreplicate x y = [ y | k <- [1..x]]

myselector :: [a] -> Int -> a
