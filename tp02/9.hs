import Data.Char

returnNext :: Bool -> Char -> [Char]
returnNext _ ' ' = [' ']
returnNext True 'Z' = ['A']
returnNext False 'A' = ['Z']
returnNext True c = [chr (ord c + 1)]
returnNext False c = [chr (ord c - 1)]

cifrar :: Int -> String -> String 
cifrar 0 str = str
cifrar n str | n < 0 = cifrar (n+1) (concatMap (returnNext False) str)
             | otherwise = cifrar (n-1) (concatMap (returnNext True) str)
