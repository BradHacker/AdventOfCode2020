import System.IO
import Data.List.Split

printLines (lines, 779) = return ()
printLines (lines, i) = do
  putStrLn (lines!!i)
  printLines (lines, i + 1)

parseLine (_, 779, x, y, wx, wy) = (x, y)
parseLine (lines, i, x, y, wx, wy) = do
  let line = lines!!i
  if line!!0 == 'N'
    then parseLine (lines, i + 1, x, y, wx, wy + read (tail line) :: Integer)
  else if line!!0 == 'S'
    then parseLine (lines, i + 1, x, y, wx, wy - read (tail line) :: Integer)
  else if line!!0 == 'E'
    then parseLine (lines, i + 1, x, y, wx + read (tail line) :: Integer, wy)
  else if line!!0 == 'W'
    then parseLine (lines, i + 1, x, y, wx - read (tail line) :: Integer, wy)
  else if line!!0 == 'L'
    then do
      if (read (tail line) :: Integer) == 90
        then parseLine (lines, i + 1, x, y, -wy, wx)
      else if (read (tail line) :: Integer) == 180
        then parseLine (lines, i + 1, x, y, -wx, -wy)
      else if (read (tail line) :: Integer) == 270
        then parseLine (lines, i + 1, x, y, wy, -wx)
      else (0, 0)
  else if line!!0 == 'R'
    then do
      if (read (tail line) :: Integer) == 90
        then parseLine (lines, i + 1, x, y, wy, -wx)
      else if (read (tail line) :: Integer) == 180
        then parseLine (lines, i + 1, x, y, -wx, -wy)
      else if (read (tail line) :: Integer) == 270
        then parseLine (lines, i + 1, x, y, -wy, wx)
      else (0, 0)
  else if line!!0 == 'F'
    then do
      let amt = (read (tail line) :: Integer)
      parseLine (lines, i + 1, x + (amt * wx), y + (amt * wy), wx, wy)
  else (0, 0)

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let lines = splitOn "\n" contents
  let (x,y) = parseLine (lines, 0, 0, 0, 10, 1)
  print (abs(x) + abs(y))
  hClose handle