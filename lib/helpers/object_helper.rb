require_relative '../base_class'

class ObjectHelper < BaseClass

  Contract String => Class
  ## Get the class (not an instance) for the given class name.
  def self.get_class_for_class_name(class_name)
    Object::const_get(class_name)
  end

  Contract String, Args[Any] => Any
  ## Instantiate (i.e., create an instance of) a class for the given class name.
  def self.instantiate_class_for_class_name(class_name, *args)
    self.get_class_for_class_name(class_name).new(*args)
  end


end

