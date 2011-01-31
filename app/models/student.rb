class Student < ActiveRecord::Base
  has_many :courses
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 40, :message => "must be 40 characters or less"
  
  validates_presence_of :grade
  validates_numericality_of :grade, :message => "must be between 9 and 12",
    :greater_than_or_equal_to => 9, :less_than_or_equal_to => 12
end
