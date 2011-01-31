class Course < ActiveRecord::Base
  belongs_to :student
  belongs_to :subject
  
  validates_presence_of :student
  
  validates_presence_of :subject
end
