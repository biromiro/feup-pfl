import Arv

sumArv :: Num a => Arv a -> a
sumArv Folha = 0
sumArv (No val esq dir) = sum [val, sumArv esq, sumArv dir]