data Map k a = Folha | No k a (Map k a) (Map k a)

empty :: Map k a
empty = Folha

insert :: Ord k => k -> a -> Map k a -> Map k a
insert key value Folha = No key value Folha Folha
insert key value (No parent parent_value left right)
  | key < parent = No parent parent_value (insert key value left) right
  | key > parent = No parent parent_value left (insert key value right)
  | otherwise = No parent parent_value left right

maplookup :: Ord k => k -> Map k a -> Maybe a
maplookup _ Folha = Nothing
maplookup key (No parent parent_value left right)
  | key == parent = Just parent_value
  | key < parent = maplookup key left
  | key > parent = maplookup key right