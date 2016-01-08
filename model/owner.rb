require 'active_record'

def pluralize(noun, count)
  count == 1 ? noun : noun + 's'
end

# An Owner of Pets
class Owner < ActiveRecord::Base
  has_many :pets, dependent: :delete_all
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    "#{id}: #{full_name} has #{pets.length} #{pluralize('pet', pets.length)}"
  end
end
