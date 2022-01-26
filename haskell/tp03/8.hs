palavras :: String -> [String]
palavras "" = []
palavras x | y == "" = z
           | otherwise = y : z
            where y = takeWhile (/= ' ') x
                  z = palavras (drop 1 (dropWhile (/= ' ') x))

despalavras :: [String] -> String
despalavras = foldl (\x y -> if x /= "" then x ++ " " ++ y else y) ""