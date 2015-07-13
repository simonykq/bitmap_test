class Bitmap

    class InvalidInputError < StandardError  
    end 

    def initialize m, n, color
        raise InvalidInputError, "Columns and rows number must be a valid integer between 1 and 250" unless is_valid_integer_between?(1, 250, m, n)
        @cols, @rows = [m, n]    
        @revert_queue = []
        @forward_queue = []
        @coordinates = Array.new(@cols){ Array.new(@rows) { 'O' } }
    end 

    def self.new m=250, n=250,color='O'
        super m, n, color
    end 

    def C color='O'
        for y in 1..@rows do
            for x in 1..@cols do
                set_pixel x, y, color
            end    
        end    
    end 

    def L x, y, color='O'
        set_pixel x, y, color
    end 

    def V x, y_1, y_2, color='O'
        range = y_2 >= y_1 ? y_1..y_2 : y_2..y_1
        for i in range do
            set_pixel x, i, color
        end     
    end 

    def H x_1, x_2, y, color='O'
        range = x_2 > x_1 ? x_1..x_2 : x2..x_1
        for i in range do
            set_pixel i, y, color
        end 
    end 

    def F x, y, color='O'
        target_color = get_pixel x, y
        flood_fill x, y, target_color, color
    end 

    def S
        for y in 1..@rows do
            for x in 1..@cols do
                printf get_pixel x, y
            end  
            printf "\n"  
        end 
    end   

    private

    def set_pixel x, y, color
        raise InvalidInputError, "Column index X must be between 1 and #{@cols} and row index Y must be between 1 and #{@rows}" unless is_valid_integer_between?(1, @cols, x) && is_valid_integer_between?(1, @rows, y)
        @coordinates[x-1][y-1] = color
    end 

    def get_pixel x, y
        raise InvalidInputError, "Column index X must be between 1 and #{@cols} and row index Y must be between 1 and #{@rows}" unless is_valid_integer_between?(1, @cols, x) && is_valid_integer_between?(1, @rows, y)
        @coordinates[x-1][y-1]
    end 

    def is_valid_integer_between? lower_bound, upper_bound, *numbers
        numbers.all? {|num| num.is_a? Integer } && numbers.all? {|num| num.between? lower_bound, upper_bound }
    end    

    def flood_fill x, y, target_color, replace_color
        begin
            color = get_pixel x, y
            return if color != target_color
            return if color == replace_color
            set_pixel x, y, replace_color
            flood_fill x-1, y, target_color, replace_color
            flood_fill x+1, y, target_color, replace_color
            flood_fill x, y-1, target_color, replace_color
            flood_fill x, y+1, target_color, replace_color
        rescue InvalidInputError
            return
        end    
    end 

end 