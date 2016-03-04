module Homework.Week08.Assignment (
  first,
  abParser,
  abParser_,
  intPair,
  intOrUppercase,
  parseInteger
) where

import Homework.Week08.AParser
import Control.Applicative
import Data.Either
import Data.List.Split
import Data.List
import Text.Read
import Data.Char
-- #1
first :: (a -> b) -> (a,c) -> (b,c)
first f (a,c) = (f a,c)

instance Functor Parser where
  fmap fn (Parser run)  = Parser f
    where f = fmap (first fn) . run

-- #2
instance Applicative Parser  where
  pure  a = Parser $ \s -> Just (a,s)
  (<*>) (Parser fab )  (Parser fa) = Parser $ f
       where f     = apply . fa
             apply (Just (a,rest)) = fmap (\ (fn,r) -> (fn a, r)) $ fab rest
             apply _  = Nothing

-- #3
-- oh this is soooo cool.
pair :: Applicative f => f a -> f b -> f (a,b)
pair = liftA2 (,)

abParser :: Parser (Char, Char)
abParser = Parser $ f
  where ab = "ab"
        tuplify (a:b:_) = (a,b)
        f s
          | isInfixOf ab s = Just (tuplify ab, mconcat $ splitOn ab s)
          | otherwise      = Nothing

abParser_ :: Parser ()
abParser_ = Parser $ f
  where  f s
           | isInfixOf ab s = Just ( () , mconcat $ splitOn ab s)
           | otherwise      = Nothing
         ab   = "ab"

intPair :: Parser [Integer]
intPair = Parser f
  where f      = parser . span isRight . fmap eitherInteger . splitWhen (==' ' )
        parser ( theRights, theLefts )
             | length theRights == 2 = Just (rights theRights, mconcat $ lefts theLefts)
             | otherwise  = Nothing

eitherInteger :: String -> Either String Integer
eitherInteger s = readEither s :: Either String Integer

-- #4
instance Alternative Parser where
  empty = Parser $ \s -> Nothing
  (Parser r) <|> (Parser r') = Parser $ (\s ->  go (r s) (r' s))
    where go (Just result) _            = Just result
          go Nothing      (Just result) = Just result
          go _            _             = Nothing

-- #5
intOrUppercase :: Parser ()
intOrUppercase = parseInteger <|> parseUpper

parseInteger :: Parser ()
parseInteger = Parser $ f .  doParse
  where doParse = \s -> (takeWhile isDigit s, s)
        f ([]    , _   ) = Nothing
        f (digits, rest) = Just ((), drop (length digits) rest)

parseUpper :: Parser ()
parseUpper = Parser $  f . doParse
  where doParse = \s -> (takeWhile isUpper s, s)
        f ([]    , _   ) = Nothing
        f ((x:_) , rest) = Just ((), drop 1 rest )


