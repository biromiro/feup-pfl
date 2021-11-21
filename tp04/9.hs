import Arv

nivel :: Int -> Arv a -> [a]
nivel 0 Folha = []
nivel 0 (No val _ _) = [val]
nivel n (No val esq dir) = nivel (n - 1) esq ++ nivel (n - 1) dir