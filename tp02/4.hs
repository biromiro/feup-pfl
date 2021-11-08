divprop :: Integer -> [Integer]
divprop x = filter (\c -> x `mod` c == 0) [1..(x `div` 2)]