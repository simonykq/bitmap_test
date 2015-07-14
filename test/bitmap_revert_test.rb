require 'minitest/autorun'
require 'lib/bitmap'

class BitmapRevertTest < MiniTest::Unit::TestCase

	def setup
		@bitmap = Bitmap.new 3, 3
	end	

	def test_revert_L
		@bitmap.L 2, 2, 'L'
		@bitmap.R
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'O'
		@bitmap._R
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'L'
	end	

	def test_revert_C
		@bitmap.L 2, 2, 'A'
		@bitmap.L 2, 3, 'B'
		@bitmap.C
		@bitmap.R
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'A'
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'B'
		@bitmap._R
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'O'		
	end	

	def test_revert_V
		@bitmap.V 1, 1, 3, 'V'
		@bitmap.R
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'O'
		@bitmap._R
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'V'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'V'
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'V'
	end

    def test_revert_H
		@bitmap.H 1, 3, 1, 'H'
		@bitmap.R
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 1), 'O'
		@bitmap._R
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'H'
		assert_equal @bitmap.send(:get_pixel, 2, 1), 'H'
		assert_equal @bitmap.send(:get_pixel, 3, 1), 'H'
	end	

	# O A O      O F O 
	# A A A  ==> F F F 
	# O A O      O F O
	def test_revert_F
	    @bitmap.V 2, 1, 3, 'A'
		@bitmap.H 1, 3, 2, 'A'
		@bitmap.F 2, 2, 'F'
		@bitmap.R 
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'A'
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 1), 'A'
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'A'
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'A'
		assert_equal @bitmap.send(:get_pixel, 3, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 2), 'A'
		assert_equal @bitmap.send(:get_pixel, 3, 3), 'O' 
		@bitmap._R
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'F'
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 1), 'F'
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'F'
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'F'
		assert_equal @bitmap.send(:get_pixel, 3, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 2), 'F'
		assert_equal @bitmap.send(:get_pixel, 3, 3), 'O' 
	end	

	# OOOOO  JJJJJ
	# OOOOO  JJZZJ
	# OAOOO  JWJJJ
	# OOOOO  JWJJJ
	# OOOOO  JJJJJ
	# OOOOO  JJJJJ

	def test_example
		@bitmap = Bitmap.new 5, 6
		@bitmap.L 2, 3, 'A'
		@bitmap.F 3, 3, 'J'
		@bitmap.V 2, 3, 4, 'W'
		@bitmap.H 3, 4, 2, 'Z'

		@bitmap.R 3
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'O'		
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 4), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 5), 'O'
		assert_equal @bitmap.send(:get_pixel, 1, 6), 'O'

		assert_equal @bitmap.send(:get_pixel, 2, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'O'		
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'A'
		assert_equal @bitmap.send(:get_pixel, 2, 4), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 5), 'O'
		assert_equal @bitmap.send(:get_pixel, 2, 6), 'O'

		assert_equal @bitmap.send(:get_pixel, 3, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 2), 'O'		
		assert_equal @bitmap.send(:get_pixel, 3, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 4), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 5), 'O'
		assert_equal @bitmap.send(:get_pixel, 3, 6), 'O'

		assert_equal @bitmap.send(:get_pixel, 4, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 4, 2), 'O'		
		assert_equal @bitmap.send(:get_pixel, 4, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 4, 4), 'O'
		assert_equal @bitmap.send(:get_pixel, 4, 5), 'O'
		assert_equal @bitmap.send(:get_pixel, 4, 6), 'O'

		assert_equal @bitmap.send(:get_pixel, 5, 1), 'O'
		assert_equal @bitmap.send(:get_pixel, 5, 2), 'O'		
		assert_equal @bitmap.send(:get_pixel, 5, 3), 'O'
		assert_equal @bitmap.send(:get_pixel, 5, 4), 'O'
		assert_equal @bitmap.send(:get_pixel, 5, 5), 'O'
		assert_equal @bitmap.send(:get_pixel, 5, 6), 'O'

		@bitmap._R 3
		assert_equal @bitmap.send(:get_pixel, 1, 1), 'J'
		assert_equal @bitmap.send(:get_pixel, 1, 2), 'J'		
		assert_equal @bitmap.send(:get_pixel, 1, 3), 'J'
		assert_equal @bitmap.send(:get_pixel, 1, 4), 'J'
		assert_equal @bitmap.send(:get_pixel, 1, 5), 'J'
		assert_equal @bitmap.send(:get_pixel, 1, 6), 'J'

		assert_equal @bitmap.send(:get_pixel, 2, 1), 'J'
		assert_equal @bitmap.send(:get_pixel, 2, 2), 'J'		
		assert_equal @bitmap.send(:get_pixel, 2, 3), 'W'
		assert_equal @bitmap.send(:get_pixel, 2, 4), 'W'
		assert_equal @bitmap.send(:get_pixel, 2, 5), 'J'
		assert_equal @bitmap.send(:get_pixel, 2, 6), 'J'

		assert_equal @bitmap.send(:get_pixel, 3, 1), 'J'
		assert_equal @bitmap.send(:get_pixel, 3, 2), 'Z'		
		assert_equal @bitmap.send(:get_pixel, 3, 3), 'J'
		assert_equal @bitmap.send(:get_pixel, 3, 4), 'J'
		assert_equal @bitmap.send(:get_pixel, 3, 5), 'J'
		assert_equal @bitmap.send(:get_pixel, 3, 6), 'J'

		assert_equal @bitmap.send(:get_pixel, 4, 1), 'J'
		assert_equal @bitmap.send(:get_pixel, 4, 2), 'Z'		
		assert_equal @bitmap.send(:get_pixel, 4, 3), 'J'
		assert_equal @bitmap.send(:get_pixel, 4, 4), 'J'
		assert_equal @bitmap.send(:get_pixel, 4, 5), 'J'
		assert_equal @bitmap.send(:get_pixel, 4, 6), 'J'

		assert_equal @bitmap.send(:get_pixel, 5, 1), 'J'
		assert_equal @bitmap.send(:get_pixel, 5, 2), 'J'		
		assert_equal @bitmap.send(:get_pixel, 5, 3), 'J'
		assert_equal @bitmap.send(:get_pixel, 5, 4), 'J'
		assert_equal @bitmap.send(:get_pixel, 5, 5), 'J'
		assert_equal @bitmap.send(:get_pixel, 5, 6), 'J'

	end	

end	
