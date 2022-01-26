xor :: Bool -> Bool -> Bool 

xor True False = True
xor False True = True
xor False False = False
xor True True = False