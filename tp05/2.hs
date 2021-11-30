import Data.Maybe (isNothing)
import Stack
import Text.Read

calc :: Stack Float -> String -> Stack Float
calc stk str
  | str == "+" = push (top stkpop1 + top stk) stkpop2
  | str == "-" = push (top stkpop1 - top stk) stkpop2
  | str == "*" = push (top stkpop1 * top stk) stkpop2
  | str == "/" = push (top stkpop1 / top stk) stkpop2
  | isNothing (readMaybe str :: Maybe Float) = error "Invalid Operand/Operator"
  | otherwise = push (read str :: Float) stk
  where
    stkpop1 = pop stk
    stkpop2 = pop (pop stk)

calcularAux :: Stack Float -> [String] -> Float
calcularAux stk []
  | isEmpty stk = 0
  | isEmpty (pop stk) = top stk
  | otherwise = error "Invalid Expression"
calcularAux stk (op : lstr) = calcularAux (calc stk op) lstr

calcular :: String -> Float
calcular str = calcularAux empty (words str)

rpn :: IO ()
rpn = do
  putStr "Please insert a RPN expression:"
  expr <- getLine
  print (calcular expr)