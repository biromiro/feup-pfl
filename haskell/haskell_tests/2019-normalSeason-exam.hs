{-
    a) 3
    b) [[1,2],[3]]
    c) [11,12,13,14,15]
    d) 240
    e) []
    f) False
    g) [(1,1), (4,4), (9,7) ,(16,10), (25,13), (36,16)]
    h) [(x,y) | (x,y) <- zip [1,3..] [10,8..]]
    i) Tem erro -> op x base em vez de op x base -> [5,4,3,2,1]
    k) [(Bool->Bool)->[Bool]->[Bool]]
    l) data Arv a = F a | N (Arv a) (Arv a)
    m) g :: (a -> Bool) -> [a] -> [a]
-}

notaF :: [Float] -> [Float] -> Float
notaF notas pesos = sum (zipWith (*) notas pesos)

rtf :: [[Float]] -> Int
rtf x = length (filter (not . null) (map (filter (< 8)) x))

type Vert = Int

type Graph = [(Vert, Vert)]

genpares :: Graph -> Graph
genpares graph = [(v1, v4) | (v1, v2) <- graph, (v3, v4) <- graph, v2 == v3]

transitiva :: Graph -> Bool
transitiva graph = all (`elem` graph) (genpares graph)

myiterate :: (a -> a) -> a -> [a]
myiterate f x = list where list = x : [f val | val <- list]

deleteNthAux :: Int -> Int -> [a] -> [a]
deleteNthAux _ _ [] = []
deleteNthAux val 1 (x : xs) = deleteNthAux val val xs
deleteNthAux val k (x : xs) = x : deleteNthAux val (k - 1) xs

deleteNth :: Int -> [a] -> [a]
deleteNth val = deleteNthAux val val

deleteNthLst :: Int -> [a] -> [a]
deleteNthLst val lst = [x | (x, index) <- zip lst [1 ..], index `mod` val /= 0]

data Arv a = Folha | No a (Arv a) (Arv a)

soma :: Num a => Arv a -> a
soma Folha = 0
soma (No val esq dir) = val + soma esq + soma dir

somaArv :: Num a => Arv a -> Arv a -> Arv a
somaArv Folha Folha = Folha
somaArv Folha (No val esq dir) = No val esq dir
somaArv (No val esq dir) Folha = No val esq dir
somaArv (No val1 esq1 dir1) (No val2 esq2 dir2) = No (val1 + val2) (somaArv esq1 esq2) (somaArv dir1 dir2)

emOrdem :: Arv a -> [a]
emOrdem Folha = []
emOrdem (No val esq dir) = emOrdem esq ++ [val] ++ emOrdem dir