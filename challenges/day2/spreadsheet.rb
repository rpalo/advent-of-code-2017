
# A sheet of rows and columns of values
class Spreadsheet
  def initialize(cells)
    @rows = []
    string_rows = cells.split("\n")
    string_rows.each { |row| @rows << row.split.map(&:to_i) }
  end

  def checksum
    @rows.reduce(0) do |total, this_row|
      total += this_row.max - this_row.min
    end
  end

  def to_s
    @rows.map do |row|
      row.join("  ")
    end.join("\n")
  end
end

EXAMPLE = <<~HEREDOC
  1 2 3 4 5
  5 4 3 2 1
  1 2 3 4 9
HEREDOC