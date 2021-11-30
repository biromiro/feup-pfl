import Data.List

newtype Conjunto a = Cnjt [a]

prtConjunto :: (Show a) => Conjunto a -> String
prtConjunto (Cnjt v) = show v

inserir :: Eq a => a -> Conjunto a -> Conjunto a
inserir val (Cnjt v)
  | val `elem` v = Cnjt v
  | otherwise = Cnjt (val : v)

remover :: Eq a => a -> Conjunto a -> Conjunto a
remover val (Cnjt v) = Cnjt (delete val v)

unir :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unir (Cnjt v) k = foldl (flip inserir) k v

diferenca :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
diferenca k (Cnjt v) = foldl (flip remover) k v

intersecao :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
intersecao k (Cnjt w) = diferenca k diff
  where
    diff = diferenca k (Cnjt w)