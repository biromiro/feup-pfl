import Data.List

type Booleano = Bool

type Inteiro = Int

type Fio = String

newtype Conjunto a = Cnjt (a -> Bool)

émembro :: Eq a => a -> Conjunto a -> Booleano
émembro valor (Cnjt p) = p valor

inserir :: Eq a => a -> Conjunto a -> Conjunto a
inserir val (Cnjt p) = Cnjt (\x -> p x || x == val)

remover :: Eq a => a -> Conjunto a -> Conjunto a
remover val (Cnjt p) = Cnjt (\x -> x /= val && p x)

unir :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unir (Cnjt p) (Cnjt q) = Cnjt (\x -> p x || q x)

diferença :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
diferença (Cnjt p) (Cnjt q) = Cnjt (\x -> p x && not (q x))

interseção :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
interseção (Cnjt p) (Cnjt q) = Cnjt (\x -> p x && q x)

vazio :: Conjunto a
vazio = Cnjt (const False)

paraLista :: Enum a => Conjunto a -> a -> Inteiro -> [a]
paraLista (Cnjt p) initVal n = take n (filter p [initVal ..])
