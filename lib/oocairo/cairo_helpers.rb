module Cairo  
  
  module_function

  # Validates that the given object can be interpreted as a size
  # [size] The object to validate against
  def validate_size(size)
    raise ArgumentError.new("Size must be an [x,y] array of non-negative numbers") unless 
      size.count == 2 and
      size.all? { |coordinate| coordinate > 0 }
  end
end