require_relative 'piece'

class SlidingPiece < Piece
  DIAGONALS = [[1,1],[1,-1],[-1,-1],[-1,1]]
  HORIZONTALS = [[1,0],[0,1],[-1,0],[0,-1]]

  def initialize(pos,board,color)
    super
  end

  def moves(directions,moving)
    valid_moves = []

    directions.each do |dir|
      current = add_vector(@pos,dir)
      while in_bounds?(current) && @board[*current] == NullPiece.instance
        valid_moves << current
        current = add_vector(current,dir)
      end
      if in_bounds?(current) && enemy?(current)
        valid_moves << current
      end
    end

    moving ? valid_moves.reject { |move| move_into_check?(move) } : valid_moves
  end
end

class Bishop < SlidingPiece
  def initialize(pos,board,color)
    super
    @sym = @color == :white ? "\u2657".encode('utf-8') : "\u265D".encode('utf-8')
  end

  def moves(moving)
    super(DIAGONALS,moving)
  end

  def to_s
    super " #{@sym} "
  end
end

class Rook < SlidingPiece
  def initialize(pos,board,color)
    super
    @sym = @color == :white ? "\u2656".encode('utf-8') : "\u265C".encode('utf-8')
  end

  def moves(moving)
    super(HORIZONTALS,moving)
  end

  def to_s
    super " #{@sym} "
  end
end

class Queen < SlidingPiece
  def initialize(pos,board,color)
    super
    @sym = @color == :white ? "\u2655".encode('utf-8') : "\u265B".encode('utf-8')
  end

  def moves(moving)
    super(DIAGONALS+HORIZONTALS,moving)
  end

  def to_s
    super(" #{@sym} ")
  end
end
