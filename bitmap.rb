class Bitmap

	attr_accessor :rows, :cols
	attr_accessor :coordinates

    def initialize m, n, color
    	raise "Invalid co-ordinate inputs" unless is_valid?(m, n)
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

    def L x=0, y=0, color='O'
    	raise "Index out of bound" unless x.between?(1, @cols) && y.between?(1, @rows)
    	@coordinates[x-1][y-1] = color
    end	

    def V x=0, y_1=0, y_2=0, color='O'
    	raise "Index out of bound" unless x.between?(1, @cols) && [y_1, y_2].all?{|num| num.between? 1, @rows }
    	range = y_2 >= y_1 ? y_1..y_2 : y_2..y_1
		for i in range do
			@coordinates[x-1][i-1] = color
		end		
    end	

    def H x_1=0, x_2=0, y=0, color='O'
    	raise "Index out of bound" unless [x_1, x_2].all?{|num| num.between? 1, @cols } && y.between?(1, @rows)
    	range = x_2 > x_1 ? x_1..x_2 : x2..x_1
    	for i in range do
    		@coordinates[i-1][y-1] = color
    	end	
    end	

	private

	def is_valid? m, m
		m_n = [m, n]
		m_n.all? {|num| num.is_a? Integer } && m_n.all? {|num| num.between? 1, 250 }
	end	


	end	

end	