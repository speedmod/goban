module Goban
  # 局面を表す。
  class Node
    attr_accessor :board

    # @param [Node] parent
    # @param [Move] last_move
    def initialize(parent=nil, last_move)
      @parent = parent
      if @parent
        @board = parent.board
      else
        # 初手
        @board = Array.new(9, Array.new(9))
      end
      add_move(last_move)
    end

    # @param [Move] move
    def add_move(move)
      if @board[move.x][move.y].nil?
        @board[move.x][move.y] = move.is_black
      else
        raise "(#{x},#{y})には打てません！"
      end
    end

    def add_next_move(move)
      Node.new(self, move)
    end

    def equal_to?(node)
      board == node.board
    end
  end

  class Move
    attr_accessor :x, :y, :is_black, :number

    # @param [Fixnum] x x座標（nilならpath）
    # @param [Fixnum] y y座標（nilならpath）
    # @param [True/False] is_black 黒か白か
    # @param [Fixnum] number 何手目か
    def initialize(x, y, is_black, number)
      @x = x
      @y = y
      @is_black = is_black
    end
  end

end
