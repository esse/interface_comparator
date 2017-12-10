require 'test_helper'

class InterfaceComparatorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::InterfaceComparator::VERSION
  end

  def test_correct_public_interface
    unique_public_methods = (InterfaceComparator.public_methods -
                            Module.public_methods).sort
    assert_equal %i(interfaces_are_same? diff_interfaces).sort,
                 unique_public_methods
  end

  def test_it_does_not_show_difference_for_two_same_objects
    a = Object.new
    b = Object.new
    assert InterfaceComparator.interfaces_are_same?(a, b)
  end

  def test_it_show_method_difference_for_two_very_different_object
    a = Object.new
    b = ''
    assert !InterfaceComparator.interfaces_are_same?(a, b)
  end

  def test_it_show_correct_method_difference
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method; end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal method_hash_factory(:new_method, true, false),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_difference_opposite_way
    a = Object.new
    b = Object.new
    b.instance_eval 'def new_method; end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal method_hash_factory(:new_method, false, true),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method; end'
    b.instance_eval 'def new_method(a); end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, 0, 1),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference_opposite_way
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method(a); end'
    b.instance_eval 'def new_method; end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, 1, 0),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference_with_args
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method(*args); end'
    b.instance_eval 'def new_method; end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, -1, 0),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference_with_args_opposite_way
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method; end'
    b.instance_eval 'def new_method(*args); end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, 0, -1),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference_with_named_args
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method(args:); end'
    b.instance_eval 'def new_method; end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, 1, 0),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_difference_with_named_args_opposite_way
    a = Object.new
    b = Object.new
    a.instance_eval 'def new_method; end'
    b.instance_eval 'def new_method(args:); end'
    assert !InterfaceComparator.interfaces_are_same?(a, b)
    assert_equal arity_hash_factory(:new_method, 0, 1),
                 InterfaceComparator.diff_interfaces(a, b)
  end

  def test_it_show_correct_method_arity_for_c_methods
    a = Object.new
    a.instance_eval 'def sumThem(a, b); end'
    b = CHello.new
    assert InterfaceComparator.interfaces_are_same?(a, b)
  end
end
