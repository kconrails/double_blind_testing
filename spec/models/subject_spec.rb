require 'spec_helper'

describe Subject do
  it {should belong_to :teacher}
  it {should validate_presence_of_association :teacher}
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 50, :message => "must be 50 characters or less"}

  it {should validate_presence_of :number}
end
