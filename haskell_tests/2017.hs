{-
1.
    a) [1,5,4,3]
    b) [5,6,9]
    c) 2
    d) [s15,18,21,24,27,30]
    e) 4
    f) [1,2,3,4,6,9]
    g) [1, 2, 3]
    h) [y * (-1)^y | y <- [0..10]]
    i) 8
    j) ([Char],[Float])
    k) fst :: (a,b) -> a
    l) h :: (Ord a) => a -> a -> a -> Bool
    m) f :: [a] ->  a
-}

numEqual :: Int -> Int -> Int -> Int
numEqual x y z
  | x /= y && y /= z && x /= z = 0
  | x /= y || x /= z = 2
  | otherwise = 3

area :: Float -> Float -> Float -> Float -> Float -> Float -> Float
area a b c d p q = 0.25 * sqrt (4 * (p ^ 2) * (q ^ 2) - (b ^ 2 + d ^ 2 - a ^ 2 - c ^ 2) ^ 2)

enquantoPar :: [Int] -> [Int]
enquantoPar = takeWhile even

natZip :: [a] -> [(Int, a)]
natZip x = zip (take (length x) [1 ..]) x

quadradosRec :: [Int] -> [Int]
quadradosRec [] = []
quadradosRec (x : xs) = (x ^ 2) : quadradosRec xs

quadradosLista :: [Int] -> [Int]
quadradosLista x = [y ^ 2 | y <- x]

crescente :: [Int] -> Bool
crescente [] = True
crescente [x] = True
crescente (x : y : lst) = (x < y) && crescente lst

partesAux :: Int -> [Int] -> [Int] -> [[Int]]
partesAux _ [] _ = []
partesAux 0 _ y = [y]
partesAux n left@(x : xs) right
  | n <= 0 = []
  | otherwise = partesAux (n - x) left (x : right) ++ partesAux n xs right

partes :: Int -> [[Int]]
partes n = reverse (partesAux n [n, (n - 1) .. 1] [])