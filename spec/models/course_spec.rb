require 'spec_helper'

describe Course do
  it {should belong_to :student}
  it {should validate_presence_of_association :student}

  it {should belong_to :subject}  
  it {should validate_presence_of_association :subject}

  it {should set_default_for :grade_percentage, :to => 1.0}
end
