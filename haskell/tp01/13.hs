safetail :: [a] -> [a]

-- safetail x = if null x then [] else tail x
safetail x | null x = []
           | otherwise = tail x

--safetail [] = []
--safetail x = tail x
