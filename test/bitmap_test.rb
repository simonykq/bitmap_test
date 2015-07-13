require 'minitest/autorun'
require 'lib/bitmap'

class BitmapTest < MiniTest::Unit::TestCase

	def setup
		@bitmap = Bitmap.new 3, 3
	end	

	def test_is_valid_integer_between?
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 2), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 1), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 3), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 1, 2, 3), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 0), false
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 0, 1, 2), false
	end	

	def test_set_pixel
		@bitmap.send(:set_pixel, 1, 1, 'S')
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'S'
		assert_raises(Bitmap::InvalidInputError) { @bitmap.send(:set_pixel, 0, 0, 'S') }
	end	

	def test_get_pixel
		color = @bitmap.send(:get_pixel, 1, 1)
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal color, coordinates[0][0]
		assert_raises(Bitmap::InvalidInputError) { @bitmap.send(:get_pixel, 0, 0) }
	end	

	def test_C
		@bitmap.L 1, 1, 'C'
		@bitmap.L 1, 2, 'C'
		@bitmap.L 1, 3, 'C'
		@bitmap.C
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'O'
		assert_equal coordinates[0][1], 'O'
		assert_equal coordinates[0][2], 'O'
	end	

	def test_L
		@bitmap.L 1, 1, 'L'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'L'
	end	

	def test_V
		@bitmap.V 1, 1, 3, 'V'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'V'
		assert_equal coordinates[0][1], 'V'
		assert_equal coordinates[0][2], 'V'	
	end	

	def test_H
		@bitmap.H 1, 3, 1, 'H'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'H'
		assert_equal coordinates[1][0], 'H'
		assert_equal coordinates[2][0], 'H'
	end	

	def test_F_1
		@bitmap.F 2, 2, 'F'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'F'
		assert_equal coordinates[0][1], 'F'
		assert_equal coordinates[0][2], 'F'
		assert_equal coordinates[1][0], 'F'
		assert_equal coordinates[1][1], 'F'
		assert_equal coordinates[1][2], 'F'
		assert_equal coordinates[2][0], 'F'
		assert_equal coordinates[2][1], 'F'
		assert_equal coordinates[2][2], 'F'
	end	

	# O A O      O F O 
	# A A A  ==> F F F 
	# O A O      O F O
	def test_F_2
		@bitmap.V 2, 1, 3, 'A'
		@bitmap.H 1, 3, 2, 'A'
		@bitmap.F 2, 2, 'F'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'O'
		assert_equal coordinates[0][1], 'F'
		assert_equal coordinates[0][2], 'O'
		assert_equal coordinates[1][0], 'F'
		assert_equal coordinates[1][1], 'F'
		assert_equal coordinates[1][2], 'F'
		assert_equal coordinates[2][0], 'O'
		assert_equal coordinates[2][1], 'F'
		assert_equal coordinates[2][2], 'O'
	end	

	# O A O      O F O
	# A A O  ==> F F O 
	# O O O      O O O
	def test_F_3
		@bitmap.L 2, 2, 'A'
		@bitmap.L 2, 1, 'A'
		@bitmap.L 1, 2, 'A'
		@bitmap.F 2, 2, 'F'
		coordinates = @bitmap.instance_variable_get(:@coordinates)
		assert_equal coordinates[0][0], 'O'
		assert_equal coordinates[0][1], 'F'
		assert_equal coordinates[0][2], 'O'
		assert_equal coordinates[1][0], 'F'
		assert_equal coordinates[1][1], 'F'
		assert_equal coordinates[1][2], 'O'
		assert_equal coordinates[2][0], 'O'
		assert_equal coordinates[2][1], 'O'
		assert_equal coordinates[2][2], 'O'
	end	

    # J J J J J
    # J J Z Z J
    # J W J J J
    # J W J J J
    # J J J J J
    # J J J J J
	def test_example
		@bitmap = Bitmap.new 5, 6
		@bitmap.L 2, 3, 'A'
		@bitmap.F 3, 3, 'J'
		@bitmap.V 2, 3, 4, 'W'
		@bitmap.H 3, 4, 2, 'Z'

		coordinates = @bitmap.instance_variable_get(:@coordinates)

		assert_equal coordinates[0][0], 'J'
		assert_equal coordinates[0][1], 'J'		
		assert_equal coordinates[0][2], 'J'
		assert_equal coordinates[0][3], 'J'
		assert_equal coordinates[0][4], 'J'
		assert_equal coordinates[0][5], 'J'

		assert_equal coordinates[1][0], 'J'
		assert_equal coordinates[1][1], 'J'
		assert_equal coordinates[1][2], 'W'
		assert_equal coordinates[1][3], 'W'
		assert_equal coordinates[1][4], 'J'
		assert_equal coordinates[1][5], 'J'

		assert_equal coordinates[2][0], 'J'
		assert_equal coordinates[2][1], 'Z'
		assert_equal coordinates[2][2], 'J'
		assert_equal coordinates[2][3], 'J'
		assert_equal coordinates[2][4], 'J'
		assert_equal coordinates[2][5], 'J'

		assert_equal coordinates[3][0], 'J'
		assert_equal coordinates[3][1], 'Z'
		assert_equal coordinates[3][2], 'J'
		assert_equal coordinates[3][3], 'J'
		assert_equal coordinates[3][4], 'J'
		assert_equal coordinates[3][5], 'J'

		assert_equal coordinates[4][0], 'J'
		assert_equal coordinates[4][1], 'J'
		assert_equal coordinates[4][2], 'J'
		assert_equal coordinates[4][3], 'J'
		assert_equal coordinates[4][4], 'J'
		assert_equal coordinates[4][5], 'J'

	end	

end	