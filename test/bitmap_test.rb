require 'minitest/autorun'
require 'lib/bitmap'

class BitmapTest < MiniTest::Unit::TestCase

	def setup
		@bitmap = Bitmap.new 1, 3
	end	

	def test_is_valid_integer_between?
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 2), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 1), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 3), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 1, 2, 3), true
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 0), false
		assert_equal @bitmap.send(:is_valid_integer_between?, 1, 3, 0, 1, 2), false
	end	
end	