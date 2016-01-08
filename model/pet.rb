require 'active_record'

# A Pet
class Pet < ActiveRecord::Base
  belongs_to :owner
  validates_presence_of :name, :age, :type

  def to_s
    "#{id}: #{name} is a #{age} year old #{type} owned by #{owner.full_name}"
  end
end

# A Dog
class Dog < Pet
  def speak
    "#{name} says woof woof!"
  end
end

class Cat < Pet
  def speak
    "#{name} says meow"
  end
end

# A Bird
class Bird < Pet
  def speak
    "#{name} says chirp!"
  end
end
