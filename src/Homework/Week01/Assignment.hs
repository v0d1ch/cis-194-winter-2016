module Homework.Week01.Assignment where
-- #1a
toDigits :: Integer -> [Integer]
toDigits n
  | n <= 0 = []
  | otherwise = toDigits(n `div` 10) ++ [n `mod` 10]

-- #1b
toDigitsRev :: Integer -> [Integer]
toDigitsRev n = reverse (toDigits n)

returnADoubleValueIfIndexIsEvenElseReturnSameValueFromList :: Int -> [Integer] -> Integer
returnADoubleValueIfIndexIsEvenElseReturnSameValueFromList n list
  | n `mod` 2 == 1 = 2 * head (drop n list)
  | otherwise = head (drop n list)

-- #2
doubleEveryOtherFromLeft :: [Integer] -> (Int -> [Integer] -> Integer) -> [Integer]
doubleEveryOtherFromLeft list accFunc = foldr (\x y -> accFunc x list : y) [] [0 .. length list - 1]

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther list = reverse (doubleEveryOtherFromLeft (reverse list) returnADoubleValueIfIndexIsEvenElseReturnSameValueFromList)

-- #3
sumDigits :: [Integer] -> Integer
sumDigits list = sum(concatMap toDigits list)
-- #4
validate :: Integer -> Bool
validate n = sumDigits (doubleEveryOther (toDigits n) ) `mod` 10 == 0

-- #5
type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi = undefined

hanoi4 :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
hanoi4 = undefined
