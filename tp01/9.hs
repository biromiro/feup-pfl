classifica :: Int -> String
classifica x | x < 0 || x > 20 = "invalido"
             | x <= 9 = "reprovado"
             | x <= 12 = "suficiente"
             | x <= 15 = "bom"
             | x <= 18 = "muito bom"
             | x <= 20 = "muito bom com distincao"
