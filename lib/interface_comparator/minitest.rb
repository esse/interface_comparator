module Minitest::Assertions
  #
  #  Fails unless +object_a and +object_a have the same interfaces (in terms of method and their arity).
  #
  def assert_equal_interfaces(object_a, object_b)
    assert InterfaceComparator.same?(object_a, object_b),
      "Interfaces are not the same: #{InterfaceComparator.diff_interfaces(object_a, object_b)}"
  end

  #
  #  Fails if +object_a and +object_a have the same interfaces (in terms of method and their arity).
  #
  def refute_equal_interfaces(object_a, object_b)
    refute InterfaceComparator.same?(object_a, object_b),
      "Interfaces are of these two object are the same"
  end
end
