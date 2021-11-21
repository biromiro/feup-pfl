import Arv

decrescente :: Arv a -> [a]
decrescente Folha = []
decrescente (No val esq dir) = decrescente dir ++ [val] ++ decrescente esq

maisDir :: Arv a -> a
maisDir (No val _ Folha) = val
maisDir (No _ _ dir) = maisDir dir

removerMaisDir :: Ord a => Arv a -> Arv a
removerMaisDir x@(No val esq dir)
  | val == maisDir x = Folha
  | otherwise = No val esq (removerMaisDir dir)