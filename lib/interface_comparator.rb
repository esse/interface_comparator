require 'interface_comparator/version'

# Module that checks if two objects has the same interface
# including public methods list and their arity
module InterfaceComparator
  # is the interface of this two objects are the same?
  def self.interfaces_are_same?(a, b)
    diff_interfaces(a, b).empty?
  end

  # show me the difference between interface of these two objects
  def self.diff_interfaces(a, b)
    methods_diff = diff_methods(a, b)
    return methods_diff unless methods_diff.empty?
    arity_diff = methods_arity_diff(a, b)
    return arity_diff unless arity_diff.empty?
    []
  end

  def self.diff_methods(a, b)
    a_methods = a.public_methods
    b_methods = b.public_methods
    a_minus_b = (a_methods - b_methods).map do |method|
      hash_factory(method, true, false)
    end
    b_minus_a = (b_methods - a_methods).map do |method|
      hash_factory(method, false, true)
    end
    a_minus_b + b_minus_a
  end
  private_class_method :diff_methods

  def self.methods_arity_diff(a, b)
    public_methods = a.public_methods
    public_methods.reject! do |method|
      a.method(method).arity == b.method(method).arity
    end
    public_methods.map do |method|
      arity_hash_factory(
        method, a.method(method).arity, b.method(method).arity
      )
    end
  end
  private_class_method :methods_arity_diff

  def self.hash_factory(method, first, second)
    {
      method: method,
      first_object: first,
      second_object: second
    }
  end
  private_class_method :hash_factory

  def self.arity_hash_factory(method, first, second)
    {
      method: method,
      first_object_arity: first,
      second_object_arity: second
    }
  end
  private_class_method :arity_hash_factory
end
