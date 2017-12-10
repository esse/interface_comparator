require 'test_helper'
require 'interface_comparator/minitest'

class TestAssertions < Minitest::Test
  def test_it_does_not_show_difference_for_two_same_objects
    a = Object.new
    b = Object.new
    assert_equal_interfaces a, b
  end

  def test_it_show_method_difference_for_two_very_different_object
    a = Object.new
    b = ''
    refute_equal_interfaces a, b
  end
end
