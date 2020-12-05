MAX_ROW = 127
MAX_COL = 7

inputFile = File.read("input.txt")
inputs = inputFile.split("\n")
puts "#{inputs.length} Tickets inputted..."

seats = inputs.map { |input|
  curr_max_row = MAX_ROW
  curr_min_row = 0
  curr_max_col = MAX_COL
  curr_min_col = 0
  input.split("").each do |c|
    if c == "F"
      if (curr_max_row - curr_min_row).abs == 1
        curr_max_row = curr_min_row
      else
        curr_max_row -= (curr_max_row - curr_min_row) / 2 + 1
      end
    elsif c == "B"
      if (curr_max_row - curr_min_row).abs == 1
        curr_min_row = curr_max_row
      else
        curr_min_row += (curr_max_row - curr_min_row) / 2 + 1
      end
    elsif c == "L"
      if (curr_max_col - curr_min_col).abs == 1
        curr_max_col = curr_min_col
      else
        curr_max_col -= (curr_max_col - curr_min_col) / 2 + 1
      end
    elsif c == "R"
      if (curr_max_col - curr_min_col).abs == 1
        curr_min_col = curr_max_col
      else
        curr_min_col += (curr_max_col - curr_min_col) / 2 + 1
      end
    end
  end

  (8 * curr_min_row) + curr_min_col
}

seats = seats.sort

for i in 0..(seats.length / 2)
  if seats[i+1] - seats[i] != 1
    puts "Missing seat is: #{seats[i] + 1}"
    break
  end
  if seats[seats.length - 1 - i] - seats[seats.length - 1 - i - 1] != 1
    puts "Missing seat is: #{seats[seats.length - 1 - i] - 1}"
    break
  end
end