require_relative 'board'
require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],@board)
  end

  def render(highlight_pos)
    @board.grid.each_with_index do |row, i|
      row_string = ""
      row.each_with_index do |piece, j|
        if [i,j] == highlight_pos
          row_string << "#{piece.to_s}".red
        elsif [i,j] == @cursor.cursor_pos
          row_string << "#{piece.to_s}".colorize(:background => :red)
        elsif piece == NullPiece.instance
          background = (i + j) % 2 == 0 ? :black : :green
          row_string << "   ".colorize(:background => background)
        else
          row_string << "#{piece.to_s}"
        end
      end
      puts row_string
    end
    p
  end

end

# b = Board.new
# d = Display.new(b)
# p d.cursor.cursor_pos
# while true
#   d.cursor.get_input
#   p d.cursor.cursor_pos
#   d.render
# end
