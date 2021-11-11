mdc :: Int -> Int -> Int
mdc a b = fst (until ((== 0) . snd) (\(a,b) -> (b, a `mod` b)) (a,b))