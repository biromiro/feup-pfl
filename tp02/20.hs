myinsert :: Ord a => a -> [a] -> [a]
myinsert x y | null y = [x]
             | head y > x = x : y
             | otherwise = head y : myinsert x (tail y)

myisort :: Ord a => [a] -> [a]
myisort x | null x = []
          | otherwise = myinsert (head x) (myisort (tail x))