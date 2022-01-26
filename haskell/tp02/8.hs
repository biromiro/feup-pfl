import Binom

pascal :: Integer -> [[Integer]]
pascal n = [[binom c k | k <- [0..c]] | c <- [0..n]]