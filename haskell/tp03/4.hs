import Prelude
import Data.List

isort :: Ord a => [a] -> [a]
isort = foldr insert []