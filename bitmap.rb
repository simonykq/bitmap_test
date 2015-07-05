class Bitmap

	attr_accessor :rows, :cols
	attr_accessor :coordinates

    def initialize m, n, color
    	raise "Invalid co-ordinate inputs" unless is_valid?(m, n)
    	@cols, @rows = [m, n]
    	@coordinates = Array.new(@rows){ Array.new(@cols) { 'O' } }
    end	

    def self.new m=250, n=250,color='O'
    	super m, n, color
    end	

    def C color='O'
    	@coordinates.each do |row|
    		row.each do |cell|
 				cell = color
    		end	
    	end	
    end	

    def L x, y, color
    	raise "Index out of bound" unless x.between?(0, @rows-1) && y.between?(0, @columns-1)
    	@coordinates[x][y] = color
    end		

	private

	def is_valid? m, m
		m_n = [m, n]
		m_n.all? {|num| num.is_a? Integer } && m_n.all? {|num| num.between? 1, 250 }
	end	


	end	

end	