raizes :: Float -> Float -> Float -> (Maybe Float, Maybe Float)
raizes a b c  | delta < 0 = (Nothing , Nothing)
              | delta == 0 = (Just (-b / (2 * a)), Nothing)
              | otherwise = let x = sqrt delta
                            in (Just ((-b + x) / (2 * a)), Just ((-b - x) / (2 * a)))
              where delta = (b ^ 2) - (4 * a * c)

-- props para o baltazoiro