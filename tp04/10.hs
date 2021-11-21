import Arv

decrescente :: Arv a -> [a]
decrescente Folha = []
decrescente (No val esq dir) = decrescente dir ++ [val] ++ decrescente esq

mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Folha = Folha
mapArv f (No val esq dir) = No (f val) (mapArv f esq) (mapArv f dir)