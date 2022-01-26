import Data.List

type Booleano = Bool

type Fio = String

newtype Conjunto a = Cnjt [a]

imprimirConjunto :: (Show a) => Conjunto a -> Fio
imprimirConjunto (Cnjt v) = show v

émembro :: Eq a => a -> Conjunto a -> Booleano
émembro valor (Cnjt v) = valor `elem` v

inserir :: Eq a => a -> Conjunto a -> Conjunto a
inserir val (Cnjt v)
  | val `elem` v = Cnjt v
  | otherwise = Cnjt (val : v)

remover :: Eq a => a -> Conjunto a -> Conjunto a
remover val (Cnjt v) = Cnjt (delete val v)

unir :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unir (Cnjt v) k = foldl (flip inserir) k v

diferença :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
diferença k (Cnjt v) = foldl (flip remover) k v

interseção :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
interseção k (Cnjt w) = diferença k diff
  where
    diff = diferença k (Cnjt w)

vazio :: Conjunto a
vazio = Cnjt []

estáVazio :: Conjunto a -> Booleano
estáVazio (Cnjt v) = null v

deLista :: [a] -> Conjunto a
deLista = Cnjt

paraLista :: Conjunto a -> [a]
paraLista (Cnjt v) = v