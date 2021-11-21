import Arv

decrescente :: Arv a -> [a]
decrescente Folha = []
decrescente (No val esq dir) = decrescente dir ++ [val] ++ decrescente esq