last1 :: [a] -> a
last1 x = head (reverse x)

last2 :: [a] -> a
last2 x = head (drop (length x - 1) x)

init1 :: [a] -> [a]
init1 x = reverse (drop 1 (reverse x))

init2 :: [a] -> [a]
init2 x = take (length x - 1) x