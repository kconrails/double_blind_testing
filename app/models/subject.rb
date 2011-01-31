class Subject < ActiveRecord::Base
  belongs_to :teacher
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 50, :message => "must be 50 characters or less"
  
  validates_presence_of :number
  
  validates_presence_of :teacher
end
