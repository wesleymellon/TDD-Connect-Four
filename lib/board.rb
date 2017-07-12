module ConnectFour 
  class Board

    attr_accessor :map, :x_count, :o_count
    def initialize
      @map = [['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
        ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
        ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_']]
      @x_count = 0
      @o_count = 0
    end

    def check_piece(x,y)
      if @map[y][x] == 'x'
        @x_count += 1
        @o_count = 0
        return true if @x_count == 4
      elsif @map[y][x] == 'o'
        @x_count = 0
        @o_count += 1
        return true if @o_count == 4
      else 
        @x_count = 0
        @o_count = 0
      end
      false
    end

    def add_piece(player, location)
      return false unless location.is_a?(Integer) && player.is_a?(String)
      for i in 0..@map.length do
        if @map[i][location] == '_'
          @map[i][location] = player
          break
        end
      end
    end

    def game_end_vert?
      for i in 0...@map[0].length do
        for j in 0...@map.length do
          if @map[j][i] == 'x'
            @x_count += 1
            @o_count = 0
            return true if @x_count == 4
          elsif @map[j][i] == 'o'
            @o_count += 1
            @x_count = 0
            return true if @o_count == 4
          else
            @x_count = 0
            @o_count = 0
          end
        end
      end
      return false
    end

    def game_end_horz?
      for i in 0...@map.length do
        for j in 0...@map[0].length do
          if @map[i][j] == 'x'
            @x_count += 1
            @o_count = 0
            return true if @x_count == 4
          elsif @map[i][j] == 'o'
            @o_count += 1
            @x_count = 0
            return true if @o_count == 4
          else
            @x_count = 0
            @o_count = 0
          end
        end
      end
      return false
    end

    def game_end_diag?
      valid_forward_start = [[2,0], [1,0], [0,0], [0,1], [0,2], [0,3]]
      valid_backward_start = [[0,3], [0,4], [0,5], [0,6], [1,6], [2,6]]

      valid_forward_start.each do |start|
        x = start[1]
        y = start[0]
        while x < @map[0].length && y < @map.length
          return true if check_piece(x,y)
          x += 1
          y += 1
        end
      end

      valid_backward_start.each do |start|
        x = start[1]
        y = start[0]
        while x > 0 && y < @map.length
          return true if check_piece(x,y)
          x -= 1
          y += 1
        end
      end
      return false
    end
  end
end