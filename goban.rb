module Goban
  # 局面を表す。
  class Node
    attr_accessor :parent, :board, :last_move

    # @param [Node] parent
    # @param [Move] last_move
    def initialize(parent=nil, move)
      @parent = parent
      if @parent
        @board = copy(parent.board)
      else
        # 初手
        @board = Array.new(9).map{ Array.new(9) }
      end
      add_move(move)
    end

    def copy(array)
      board = Array.new(9).map{ Array.new(9) }
      array.each.with_index do |row, y|
        row.each.with_index do |val, x|
          board[y][x] = val
        end
      end
      board
    end

    def show
      @board.each.with_index do |row, y|
        row.each.with_index do |is_black, x|
          cross = if is_black.nil?
                    if x == 0
                      y == 0 ? "┏" : (y == 8 ? "┗" : "┣")
                    elsif x == 8
                      y == 0 ? "┓" : (y == 8 ? "┛" : "┫")
                    else
                      y == 0 ? "┳" : (y == 8 ? "┻" : "╋")
                    end
                  else
                    is_black ? "●" : "◯"
                  end
          print cross
        end
        puts ""
      end
    end

    # @param [Move] move
    def add_move(move)
      if @board[move.x][move.y].nil?
        @board[move.x][move.y] = move.is_black
      else
        raise "(#{move.x},#{move.y})には打てません！"
      end
    end

    def next_move(move)
      Node.new(self, move)
    end

    def equal_to?(node)
      board == node.board
    end
  end

  class Move
    attr_accessor :x, :y, :is_black, :number

    # @param [Fixnum] x x座標（0始まり、nilならpath）
    # @param [Fixnum] y y座標（0始まり、nilならpath）
    # @param [True/False] is_black 黒か白か
    # @param [Fixnum] number 何手目か
    def initialize(y, x, is_black, number)
      @x = x
      @y = y
      @is_black = is_black
    end
  end
end

n = Goban::Node.new(nil, Goban::Move.new(3, 4, true, 1))
n.show
n2 = n.next_move(Goban::Move.new(4, 3, false, 2))
n2.show
n2.parent.show
