class Bitmap

    attr_accessor :rows, :cols
    attr_accessor :coordinates

    def initialize m, n, color
        raise "Invalid co-ordinate inputs" unless is_valid?(m, n)
        @cols, @rows = [m, n]
        @coordinates = Array.new(@cols){ Array.new(@rows) { 'O' } }
    end 

    def self.new m=250, n=250,color='O'
        super m.to_i, n.to_i, color
    end 

    def C color='O'
        @coordinates.each do |column|
            column.each do |cell|
                cell = color
            end 
        end 
    end 

    def L x, y, color='O'
        x, y = [x.to_i, y.to_i]
        return unless x.between?(1, @cols) && y.between?(1, @rows)
        @coordinates[x-1][y-1] = color
    end 

    def V x, y_1, y_2, color='O'
        x, y_1, y_2 = [x.to_i, y_1.to_i, y_2.to_i]
        return unless x.between?(1, @cols) && [y_1, y_2].all?{|num| num.between? 1, @rows }
        range = y_2 >= y_1 ? y_1..y_2 : y_2..y_1
        for i in range do
            @coordinates[x-1][i-1] = color
        end     
    end 

    def H x_1, x_2, y, color='O'
        x_1, x_2, y = [x_1.to_i, x_2.to_i, y.to_i]
        return unless [x_1, x_2].all?{|num| num.between? 1, @cols } && y.between?(1, @rows)
        range = x_2 > x_1 ? x_1..x_2 : x2..x_1
        for i in range do
            @coordinates[i-1][y-1] = color
        end 
    end 

    def F x, y, color='O'
        x, y = [x.to_i, y.to_i]
        target_color = @coordinates[x-1][y-1]
        flood_fill x, y, target_color, color
    end 

    def S
        for y in 1..@rows do
            for x in 1..@cols do
                printf @coordinates[x-1][y-1]
            end  
            printf "\n"  
        end 
    end    

    private

    def is_valid? m, n
        m_n = [m, n]
        m_n.all? {|num| num.is_a? Integer } && m_n.all? {|num| num.between? 1, 250 }
    end 

    def flood_fill x, y, target_color, replace_color
        return unless x.between?(1, @cols) && y.between?(1, @rows)
        return if @coordinates[x-1][y-1] != target_color
        return if @coordinates[x-1][y-1] == replace_color
        @coordinates[x-1][y-1] = replace_color
        flood_fill x-1, y, target_color, replace_color
        flood_fill x+1, y, target_color, replace_color
        flood_fill x, y-1, target_color, replace_color
        flood_fill x, y+1, target_color, replace_color
    end 

end 