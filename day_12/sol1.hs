import System.IO
import Data.List.Split

printLines (lines, 779) = return ()
printLines (lines, i) = do
  putStrLn (lines!!i)
  printLines (lines, i + 1)

parseLine (_, 779, x, y, _) = (x, y)
parseLine (lines, i, x, y, dir) = do
  let line = lines!!i
  if line!!0 == 'N'
    then parseLine (lines, i + 1, x, y + read (tail line) :: Integer, dir)
  else if line!!0 == 'S'
    then parseLine (lines, i + 1, x, y - read (tail line) :: Integer, dir)
  else if line!!0 == 'E'
    then parseLine (lines, i + 1, x + read (tail line) :: Integer, y, dir)
  else if line!!0 == 'W'
    then parseLine (lines, i + 1, x - read (tail line) :: Integer, y, dir)
  else if line!!0 == 'L'
    then parseLine (lines, i + 1, x, y, mod (dir + (360 - read (tail line) :: Integer)) 360)
  else if line!!0 == 'R'
    then parseLine (lines, i + 1, x, y, mod (dir + read (tail line) :: Integer) 360)
  else if line!!0 == 'F'
    then do
      if dir == 0
        then parseLine (lines, i + 1, x + read (tail line) :: Integer, y, dir)
      else if dir == 90
        then parseLine (lines, i + 1, x, y - read (tail line) :: Integer, dir)
      else if dir == 180
        then parseLine (lines, i + 1, x - read (tail line) :: Integer, y, dir)
      else if dir == 270
        then parseLine (lines, i + 1, x, y + read (tail line) :: Integer, dir)
      else (0, 0)
  else (0, 0)

main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let lines = splitOn "\n" contents
  let (x,y) = parseLine (lines, 0, 0, 0, 0)
  print (abs(x) + abs(y))
  hClose handle