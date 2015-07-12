class Bitmap

    attr_accessor :rows, :cols
    attr_accessor :coordinates

    def initialize m, n, color
        raise "Invalid column or row numbers" unless is_valid_integer_between?(1, 250, m, n)
        @cols, @rows = [m, n]
        @coordinates = Array.new(@cols){ Array.new(@rows) { 'O' } }
    end 

    def self.new m=250, n=250,color='O'
        super m, n, color
    end 

    def C color='O'
        @coordinates.each do |column|
            column.each do |cell|
                cell = color
            end 
        end 
    end 

    def L x, y, color='O'
        raise "Invalid x or y inputs" unless is_valid_integer_between?(1, @cols, x) && is_valid_integer_between?(1, @rows, y)
        @coordinates[x-1][y-1] = color
    end 

    def V x, y_1, y_2, color='O'
        raise "Invalid x or y inputs" unless is_valid_integer_between?(1, @cols, x) && is_valid_integer_between?(1, @rows, y_1, y_2)
        range = y_2 >= y_1 ? y_1..y_2 : y_2..y_1
        for i in range do
            @coordinates[x-1][i-1] = color
        end     
    end 

    def H x_1, x_2, y, color='O'
        raise "Invalid x or y inputs" unless is_valid_integer_between?(1, @cols, x_1, x_2) && is_valid_integer_between?(1, @rows, y)
        range = x_2 > x_1 ? x_1..x_2 : x2..x_1
        for i in range do
            @coordinates[i-1][y-1] = color
        end 
    end 

    def F x, y, color='O'
        raise "Invalid x or y inputs" unless is_valid_integer_between?(1, @cols, x) && is_valid_integer_between?(1, @rows, y)
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

    def is_valid_integer_between? lower_bound, upper_bound, *numbers
        numbers.all? {|num| num.is_a? Integer } && numbers.all? {|num| num.between? lower_bound, upper_bound }
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