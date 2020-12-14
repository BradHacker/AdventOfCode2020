defmodule AOC do
  def advanceSeats(lines) do
    advanceSeats(
      lines,
      [""],
      Kernel.length(lines) * String.length(Enum.at(lines, 0)) - 1,
      Kernel.length(lines) * String.length(Enum.at(lines, 0))
    )
  end

  def advanceSeats(prevGen, currGen, cursor, maxCursor) when cursor >= 0 do
    row = trunc(cursor / String.length(hd(prevGen)))
    col = rem(cursor, String.length(hd(prevGen)))

    IO.puts("#{row}, #{col} | #{currGen}")

    case String.at(Enum.at(prevGen, row), col) do
      "." ->
        nextGen = if col == 0, do: ["."] ++ currGen, else: ["." <> hd(currGen)] ++ tl(currGen)

        advanceSeats(prevGen, nextGen, cursor - 1, maxCursor)

      "L" ->
        if AOC.adjacentIsEmpty(prevGen, row, col) do
          IO.puts(hd(currGen))

          nextGen = if col == 0, do: ["#"] ++ currGen, else: ["#" <> hd(currGen)] ++ tl(currGen)

          advanceSeats(prevGen, nextGen, cursor - 1, maxCursor)
        else
          nextGen = if col == 0, do: ["L"] ++ currGen, else: ["L" <> hd(currGen)] ++ tl(currGen)

          advanceSeats(prevGen, nextGen, cursor - 1, maxCursor)
        end

      "#" ->
        if AOC.isSociallyDistanced(prevGen, row, col, -1, -1, 0) do
          nextGen = if col == 0, do: ["#"] ++ currGen, else: ["#" <> hd(currGen)] ++ tl(currGen)

          advanceSeats(prevGen, nextGen, cursor - 1, maxCursor)
        else
          nextGen = if col == 0, do: ["L"] ++ currGen, else: ["L" <> hd(currGen)] ++ tl(currGen)

          advanceSeats(prevGen, nextGen, cursor - 1, maxCursor)
        end

      _ ->
        # advanceSeats(prevGen, currGen, cursor - 1, maxCursor)
        currGen
    end
  end

  def advanceSeats(_prevGen, currGen, _cursor) do
    currGen
  end

  def adjacentIsEmpty(lines, row, col)
      when is_list(lines) and is_integer(row) and is_integer(col) do
    numCols = String.length(Enum.at(lines, 0))
    numRows = Kernel.length(lines)

    topRowExists = row - 1 >= 0
    bottomRowExists = row + 1 < numRows
    leftColExists = col - 1 >= 0
    rightColExists = col + 1 < numCols

    (!topRowExists or !leftColExists or
       (String.at(Enum.at(lines, row - 1), col - 1) == "L" or
          String.at(Enum.at(lines, row - 1), col - 1) == ".")) and
      (!topRowExists or
         (String.at(Enum.at(lines, row - 1), col) == "L" or
            String.at(Enum.at(lines, row - 1), col) == ".")) and
      (!topRowExists or !rightColExists or
         (String.at(Enum.at(lines, row - 1), col + 1) == "L" or
            String.at(Enum.at(lines, row - 1), col + 1) == ".")) and
      (!leftColExists or
         (String.at(Enum.at(lines, row), col - 1) == "L" or
            String.at(Enum.at(lines, row), col - 1) == ".")) and
      (!rightColExists or
         (String.at(Enum.at(lines, row), col + 1) == "L" or
            String.at(Enum.at(lines, row), col + 1) == ".")) and
      (!bottomRowExists or !leftColExists or
         (String.at(Enum.at(lines, row + 1), col - 1) == "L" or
            String.at(Enum.at(lines, row + 1), col - 1) == ".")) and
      (!bottomRowExists or
         (String.at(Enum.at(lines, row + 1), col) == "L" or
            String.at(Enum.at(lines, row + 1), col) == ".")) and
      (!bottomRowExists or !rightColExists or
         (String.at(Enum.at(lines, row + 1), col + 1) == "L" or
            String.at(Enum.at(lines, row + 1), col + 1) == "."))
  end

  def isSociallyDistanced(lines, row, col, cursorRow, cursorCol, numFilled)
      when cursorRow > 1 and cursorCol > 1 do
    IO.puts(numFilled)
    numFilled < 4
  end

  def isSociallyDistanced(lines, row, col, cursorRow, cursorCol, numFilled) when cursorCol > 1 do
    isSociallyDistanced(lines, row, col, cursorRow + 1, -1, numFilled)
  end

  def isSociallyDistanced(lines, row, col, cursorRow, cursorCol, numFilled)
      when cursorRow < 2 and cursorCol < 2 do
    numCols = String.length(Enum.at(lines, 0))
    numRows = Kernel.length(lines)

    evalRow = row + cursorRow
    evalCol = col + cursorCol

    if evalRow >= 0 and evalRow < numRows and
         evalCol >= 0 and evalCol < numCols and cursorCol < 2 do
      seatVal = String.at(Enum.at(lines, row + cursorRow), col + cursorCol)
      newNumFilled = if seatVal == "#", do: numFilled + 1, else: numFilled
      IO.puts("(#{cursorRow},#{cursorCol}) | #{seatVal} | #{newNumFilled}")
      isSociallyDistanced(lines, row, col, cursorRow, cursorCol + 1, newNumFilled)
    else
      isSociallyDistanced(lines, row, col, cursorRow, cursorCol + 1, numFilled)
    end
  end

  def printLayout(lines) do
    printLayout(lines, String.length(hd(lines)), length(lines) * String.length(hd(lines)) - 1)
  end

  def printLayout(lines, colWidth, cursor) do
    if cursor >= 0 do
      row = trunc(cursor / colWidth)
      col = rem(cursor, colWidth)
      IO.write(String.at(Enum.at(lines, row), col))

      if col == 0 do
        IO.write("\n")
      end

      printLayout(lines, colWidth, cursor - 1)
    end
  end
end

contents = File.read!("sample.txt")
# IO.puts(contents)

lines = String.split(contents, "\n")

# IO.puts(is_list(lines))
# IO.puts("#{Kernel.length(lines)} x #{String.length(hd(lines))}")
AOC.printLayout(lines)

firstGen =
  AOC.advanceSeats(lines, [""], Kernel.length(lines) * String.length(Enum.at(lines, 0)) - 1)

IO.puts(is_list(firstGen))
IO.puts("#{Kernel.length(firstGen)} x #{String.length(hd(firstGen))}")

AOC.printLayout(firstGen)
# secondGen =
#   AOC.advanceSeats(
#     firstGen,
#     [""],
#     Kernel.length(firstGen) * String.length(Enum.at(firstGen, 0)) - 1
#   )

# IO.puts(firstGen)
# IO.puts(secondGen)
