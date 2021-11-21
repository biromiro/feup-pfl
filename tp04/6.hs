binom :: Integer -> Integer -> Integer
binom n k
  | k < n - k = product [(n - k + 1) .. n] `div` product [1 .. k]
  | k >= n - k = product [(k + 1) .. n] `div` product [1 .. (n - k)]

pascal :: [[Integer]]
pascal = [[binom n k | k <- [0 .. n]] | n <- [0 ..]]

genListPascal :: [Integer] -> [Integer]
genListPascal x = [if k == 0 || k == n then 1 else x !! (k - 1) + x !! k | k <- [0 .. length x]]
  where
    n = length x

pascal' :: [[Integer]]
pascal' = [1] : [[if k == 0 || k == n then 1 else pascal' !! (n - 1) !! (k - 1) + pascal' !! (n - 1) !! k | k <- [0 .. n]] | n <- [1 ..]]