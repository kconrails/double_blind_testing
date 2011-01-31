require 'spec_helper'

describe Teacher do
  it "has many subjects" do
    teacher = Factory.create :teacher
    teacher.subjects.should be_empty

    subject = teacher.subjects.create Factory.attributes_for(:subject)
    teacher.subjects.should include(subject)
  end
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 50, :message => "must be 50 characters or less"}
  
  it {should validate_presence_of :salary}

  describe "salary" do
    it "is at or above $20K" do
      error_message = "must be between $20K and $100K"
      
      teacher = Teacher.new :salary => 20_000
      teacher.valid?
      teacher.errors[:salary].should_not include(error_message)

      teacher.salary -= 0.01
      teacher.should_not be_valid
      teacher.errors[:salary].should include(error_message)
    end
    
    it "is no more than $100K" do
      error_message = "must be between $20K and $100K"

      teacher = Teacher.new :salary => 100_000
      teacher.valid?
      teacher.errors[:salary].should_not include(error_message)
      
      teacher.salary += 0.01
      teacher.should_not be_valid
      teacher.errors[:salary].should include(error_message)
    end
  end
end
