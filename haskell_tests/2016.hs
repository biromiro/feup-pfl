{-
  1.
    a) [2,3,1,4,4]
    b) [0,10,20,30,40]
    c) [[],[3,4],[5]]
    d) 5
    e) [1,1,1,1,1,1]
    f) [(1,4),(2,3),(3,2)]
    g) [2^x| x <- [0..6]]
    h) 0
    i) [(Bool, Integer)]
    j) troca :: (a,b) -> (b,a)
    k) g :: (Ord a, Num a) => a -> a -> a
    l) [([a],a)]
-}

ttriangulo :: Float -> Float -> Float -> [Char]
ttriangulo a b c
  | a == b && b == c = "Equilatero"
  | a == b || b == c || a == c = "Isosceles"
  | otherwise = "Escaleno"

rectangulo :: Float -> Float -> Float -> Bool
rectangulo a b c = h ^ 2 == (c1 ^ 2 + c2 ^ 2)
  where
    h = max (max a b) c
    c1 = min (min a b) c
    c2 = (a + b + c) - h - c1

maiores :: Ord a => [a] -> [a]
maiores [] = []
maiores [x] = []
maiores (x : xs) = if x > head xs then x : maiores xs else maiores xs

somapares :: [(Int, Int)] -> [Int]
somapares [] = []
somapares ((x, y) : lst) = x + y : somapares lst

somaparesLst :: [(Int, Int)] -> [Int]
somaparesLst lst = [x + y | (x, y) <- lst]

itera :: Int -> (Int -> Int) -> Int -> Int
itera 0 _ v = v
itera n f v = itera (n - 1) f (f v)

mult :: Int -> Int -> Int
mult x y = itera y (+ x) 0