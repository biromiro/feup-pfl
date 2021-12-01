module Arv where

data Set a = Folha | No a (Set a) (Set a)

showSet :: Show a => Set a -> String
showSet Folha = ""
showSet (No val left right) = show val ++ "-{" ++ showSet left ++ "}-{" ++ showSet right ++ "}"

empty :: Set a
empty = Folha

insert :: Ord a => a -> Set a -> Set a
insert val Folha = No val Folha Folha
insert val (No x left right)
  | val < x = No x (insert val left) right
  | val > x = No x left (insert val right)
  | otherwise = No x left right

member :: Ord a => a -> Set a -> Bool
member val Folha = False
member val (No x left right)
  | val < x = member val left
  | val > x = member val right
  | otherwise = True

union, intersect, difference :: Ord a => Set a -> Set a -> Set a
union Folha y = y
union (No val left right) y = union (left `union` right) (insert val y)

insertFrom :: Ord a => Set a -> Set a -> Set a -> Bool -> Set a
insertFrom Folha y resultSet common = resultSet
insertFrom (No val left right) y resultSet common
  | if common then isMember else not isMember = insertFrom remainingSet y (insert val resultSet) common
  | otherwise = insertFrom remainingSet y resultSet common
  where
    remainingSet = left `union` right
    isMember = member val y

intersect x y = insertFrom x y empty True

difference x y = insertFrom x y empty False