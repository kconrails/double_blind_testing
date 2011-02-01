require 'spec_helper'

describe Teacher do
  it {should have_many :subjects}
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 50, :message => "must be 50 characters or less"}
  
  it {should validate_presence_of :salary}
  it {should validate_numericality_of :salary, :within => (20_000..100_000), :message => "must be between $20K and $100K"}
end
