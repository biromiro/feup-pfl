module Binom where

binom :: Integer -> Integer -> Integer
binom n k = product [1 .. n] `div` (product [1 .. k] * product [1 .. (n - k)])

binom' :: Integer -> Integer -> Integer
binom' n k
  | k < n - k = product [(n - k + 1) .. n] `div` product [1 .. k]
  | k >= n - k = product [(k + 1) .. n] `div` product [1 .. (n - k)]
