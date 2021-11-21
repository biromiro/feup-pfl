intercalar :: a -> [a] -> [[a]]
intercalar x [] = [[x]]
intercalar x ys = (ys ++ [x]) : [i ++ [last ys] | i <- intercalar x (init ys)]

unique :: (Eq a) => [a] -> [a]
unique [] = []
unique (x : xs)
  | x `elem` xs = unique xs
  | otherwise = x : unique xs

perms :: [Int] -> [[Int]]
perms [] = []
perms [c] = [[c]]
perms x = unique (concat ([intercalar (fst nLR) perm | nLR <- numListRest, perm <- perms (snd nLR)]))
  where
    numListRest = zip x listRest
    listRest = zipWith restGenFunc [0 .. length x] repList
    repList = replicate (length x) x
    restGenFunc k y = take k y ++ drop (k + 1) y