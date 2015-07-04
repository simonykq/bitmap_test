class Bitmap

	attr_accessor :coordinate

    def initialize x, y, color
    	raise "Invalid co-ordinate inputs" unless is_valid?(x, y)
    	@coordinate = Array.new(x){ Array.new(y) { 'O' } }
    end	

    def self.new x=250, y=250,color='O'
    	super x, y, color
    end		

	private

	def is_valid? x, y
		x_y = [x, y]
		x_y.all? {|num| num.is_a? Integer } && x_y.all? {|num| num.between? 1, 250 }
	end	

end	