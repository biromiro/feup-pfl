
segundo :: [a] -> a
segundo xs = head (tail xs)

trocar :: (a,b) -> (b,a)
trocar (x, y) = (y, x)

par :: a -> a -> (a,a)
par x y = (x, y)

dobro :: Num a => a -> a
dobro x = 2 * x

metade :: Fractional a => a -> a
metade x = x/2

minuscula :: Char -> Bool
minuscula x = x >='a' && x <='z'

intervalo :: Ord a => a -> a -> a -> Bool
intervalo x a b = x >= a && x <= b

palindromo :: String -> Bool
palindromo xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)