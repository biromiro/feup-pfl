import Control.Arrow (ArrowChoice (left, right))

{-
1.
    a) [[1,2,3],[4],[5]]
    b) 5
    c) [8,6,4,2,0]
    d) 9
    e) [(1,1),(2,1),(3,1),(4,1),(2,2),(3,2),(4,2)]
    f) [2,4,8,16,32]
    g) [2^x - 1 |  x <- [1..10]]
    h) 15
    i) ([Bool],[Char])
    j) p :: a -> b -> (a,b)
    k) h :: Eq a => [a] -> [a] -> [a]
    l) feql :: Eq a => [a] -> Bool
-}

distancia :: (Float, Float) -> (Float, Float) -> Float
distancia (x1, y1) (x2, y2) = sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

colineares :: (Float, Float) -> (Float, Float) -> (Float, Float) -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = d1 == d2
  where
    d1 = (y2 - y1) / (x2 - x1)
    d2 = (y3 - y2) / (x3 - x2)

niguaisRec :: Int -> a -> [a]
niguaisRec rep x = if rep <= 0 then [] else x : niguaisRec (rep - 1) x

niguaisCompr :: Int -> a -> [a]
niguaisCompr rep x
  | rep < 0 = []
  | otherwise = [x | y <- [0 .. (rep - 1)]]

merge :: Ord a => [a] -> [a] -> [a]
merge [] right = right
merge left [] = left
merge left@(x : xs) right@(y : ys)
  | x < y = x : merge xs right
  | otherwise = y : merge ys left

lengthZip :: [a] -> [(Int, a)]
lengthZip val = zip (reverse (take (length val) [1 ..])) val

decomporAux :: Int -> [Int] -> [Int] -> [[Int]]
decomporAux _ [] _ = []
decomporAux 0 _ x = [x]
decomporAux n lst@(x : xs) l
  | n <= 0 = []
  | otherwise = decomporAux (n - x) lst (x : l) ++ decomporAux n xs l

decompor :: Int -> [Int] -> [[Int]]
decompor n x = decomporAux n x []