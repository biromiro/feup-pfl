import Stack

opposite :: Char -> Char
opposite '(' = ')'
opposite '{' = '}'
opposite '[' = ']'

parentAux :: Stack Char -> String -> Bool
parentAux s str
  | null str = isEmpty s
  | x == '(' || x == '{' || x == '[' = parentAux (push x s) xs
  | x == ')' || x == '}' || x == ']' = (opposite (top s) == x) && parentAux (pop s) xs
  | otherwise = parentAux s xs
  where
    x = head str
    xs = tail str

parent :: String -> Bool
parent = parentAux empty