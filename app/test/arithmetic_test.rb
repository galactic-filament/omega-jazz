require 'minitest/autorun'
require_relative '../lib/arithmetic'

class ArithmeticTest < MiniTest::Test
  def test_add
    assert_equal 4, add(2, 2)
  end
end
