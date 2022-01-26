import DivProp

perfeitos :: Integer -> [Integer]
perfeitos x = [y | y <- [1..x], sum (divprop y) == y] 