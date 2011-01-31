class Teacher < ActiveRecord::Base
  has_many :subjects
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 50, :message => "must be 50 characters or less"
  
  validates_presence_of :salary
  validates_numericality_of :salary, :message => "must be between $20K and $100K",
    :greater_than_or_equal_to => 20_000, :less_than_or_equal_to => 100_000
end
