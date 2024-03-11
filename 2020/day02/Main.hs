module Main where

data Row = Row { rowChar :: Char
               , rowRange:: (Int, Int)
               , rowPassword :: String
               } deriving Show

tail' :: [a] -> [a]
tail' [] = []
tail' (_:xs) = xs

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn _ [] = []
splitOn d s = x:splitOn d (tail' s')
    where (x, s') = span (/= d) s

rowFromString :: String -> Row
rowFromString s = Row c (read low, read high) password
    where [policy, ' ':password] = splitOn ':' s
          [range, c:_] = splitOn ' ' policy
          [low, high] = splitOn '-' range

-- part 01
isCorrectV1 :: Row -> Bool
isCorrectV1 (Row c (low, high) password) = low <= n && n <= high
    where n = length $ filter (== c) password

-- part 02
isCorrectV2 :: Row -> Bool
isCorrectV2 (Row c (low, high) password) = (a == c) /= (b == c)
    where a = password !! (low - 1)
          b = password !! (high - 1)

countValidPasswords :: (Row -> Bool) -> [Row] -> Int
countValidPasswords predicate rows = length (filter predicate rows)

--main :: IO ()
--main = interact $ (++ "\n") . show . length . filter isCorrectV2 . map rowFromString . lines

main :: IO ()
main = do
    input <- getContents
    let rows = map rowFromString (lines input)
    putStrLn $ "part 01: " ++ show (countValidPasswords isCorrectV1 rows)
    putStrLn $ "part 02: " ++ show (countValidPasswords isCorrectV2 rows)
