testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = a + b > c && a + c > b && b + c > a

areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c 
  | testaTriangulo a b c = sqrt s*(s-a)*(s-b)*(s-c) 
  | otherwise = 0.0
  where s = (a + b + c) / 2
