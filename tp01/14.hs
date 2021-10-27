curta :: [a] -> Bool

curta x = length x < 3

curta1 :: [a] -> Bool

curta1 [] = True
curta1 [_] = True 
curta1 [_,_] = True
curta1 x = False
