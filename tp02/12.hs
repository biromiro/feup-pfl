import GHC.Unicode (isLower, isUpper)
import Data.Char (isNumber)
forte :: String -> Bool
forte x = length x >= 8 && any isLower x && any isUpper x && any isNumber x