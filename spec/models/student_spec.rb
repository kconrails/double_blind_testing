require 'spec_helper'

describe Student do
  it {should have_many :courses}
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 40, :message => "must be 40 characters or less"}

  it {should validate_presence_of :grade}
  it {should validate_numericality_of :grade, :within => (9..12), :message => "must be between 9 and 12"}
end
