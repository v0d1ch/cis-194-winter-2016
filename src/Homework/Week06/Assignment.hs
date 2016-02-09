module Homework.Week06.Assignment (
  fib,
  fibs1,
  fibs2,
  streamToList,
  streamRepeat,
  streamMap,
  streamFromSeed,
  nats,
  ruler,
  Stream(..)
) where


import Data.List

-- #1a
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibMemory :: Integer -> [Integer] -> Integer
fibMemory 0 _ = 0
fibMemory 1 _ = 1
fibMemory n mem = head mem

fibs1 :: [Integer]
fibs1 = map fib [0 .. ]

fibInf :: [Integer] -> [Integer]
fibInf (x : y : z) = x : fibInf [y , x + y]

-- #2
fibs2 :: [Integer]
fibs2 = fibInf [0,1]

-- #3
data Stream a = Stream a -- replace this with your own definition; this one is wrong

streamToList :: Stream a -> [a]
streamToList = undefined

-- instance Show a => Show (Stream a) where
--   show = ???

-- #4
streamRepeat :: a -> Stream a
streamRepeat = undefined

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap = undefined

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed = undefined

-- #5
nats :: Stream Integer
nats = undefined

ruler :: Stream Integer
ruler = undefined
