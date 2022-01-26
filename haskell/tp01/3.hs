metades :: [a] -> ([a],[a])

 -- metades x = let y = length x `div` 2 
 --            in (take y x, drop y x)

metades x = let y = length x `div` 2 
            in splitAt y x