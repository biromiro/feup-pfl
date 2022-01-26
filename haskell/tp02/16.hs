algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev x = x `mod` 10 : algarismosRev (x `div` 10)

algarismos :: Int -> [Int]
algarismos x = reverse (algarismosRev x)