import Data.Char

returnNext :: Char -> Int -> [Char]
returnNext c k = [chr (65 + ((ord c - 65 + k) `mod` 26))]

getDesl :: Char -> Int
getDesl x = ord x - 65

cifraChave :: String -> String -> String
cifraChave x y = concatMap (\k -> returnNext (fst k) (getDesl (snd k))) (zip x repeatedStr)
  where
    repeatedStr = concat (replicate ((length x `div` length y) + 1) y)