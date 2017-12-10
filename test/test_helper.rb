$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'interface_comparator'

require 'minitest/autorun'
require 'inline'

def method_hash_factory(method, first, second)
  [
    {
      method: method,
      first_object: first,
      second_object: second
    }
  ]
end

def arity_hash_factory(method, first, second)
  [
    {
      method: method,
      first_object_arity: first,
      second_object_arity: second
    }
  ]
end

class CHello
  inline do |builder|
    builder.include '<stdio.h>'
    builder.c 'int sumThem(int a, int b) {
      return a + b;
    }'
  end
end
