pitagoricos :: Integer -> [(Integer , Integer , Integer )]
pitagoricos k = [(x,y,z) | x <- [1..k], y <- [x..k], z <- [y..k] , x^2 + y^2 == z^2]

-- pitagoricos k = [(x,y,z) | x <- [1..k], y <- [x..1], z <- [y..1] , x^2 + y^2 == z^2]