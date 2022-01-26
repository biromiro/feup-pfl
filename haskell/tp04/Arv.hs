module Arv where

data Arv a = Folha | No a (Arv a) (Arv a)
