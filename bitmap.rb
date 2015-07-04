class Bitmap

	attr_accessor :rows, :columns
	attr_accessor :coordinate

    def initialize x, y, color
    	raise "Invalid co-ordinate inputs" unless is_valid?(x, y)
    	@rows, @columns = [x, y]
    	@coordinate = Array.new(@columns){ Array.new(y) { 'O' } }
    end	

    def self.new x=250, y=250,color='O'
    	super x, y, color
    end	

    def C color='O'
    	@coordinate.each do |row|
    		row.each do |cell|
 				cell = color
    		end	
    	end	
    end	

    def L x, y, color
    	raise "Index out of bound" unless x.between?(0, @rows-1) && y.between?(0, @columns-1)
    	@coordinate[x][y] = color
    end	

	private

	def is_valid? x, y
		x_y = [x, y]
		x_y.all? {|num| num.is_a? Integer } && x_y.all? {|num| num.between? 1, 250 }
	end	

end	