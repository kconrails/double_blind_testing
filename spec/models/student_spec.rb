require 'spec_helper'

describe Student do
  it "has many courses" do
    student = Factory.create :student
    student.courses.should be_empty

    course = student.courses.create Factory.attributes_for(:course)
    student.courses.should include(course)
  end
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 40, :message => "must be 40 characters or less"}

  it {should validate_presence_of :grade}
  
  describe "grade" do
    it "should be at least 9" do
      error_message = "must be between 9 and 12"
      
      student = Student.new :grade => 9
      student.valid?
      student.errors[:grade].should_not include(error_message)
      
      student.grade -= 1
      student.should_not be_valid
      student.errors[:grade].should include(error_message)
    end
    
    it "should be at most 12" do
      error_message = "must be between 9 and 12"
      
      student = Student.new :grade => 12
      student.valid?
      student.errors[:grade].should_not include(error_message)
      
      student.grade += 1
      student.should_not be_valid
      student.errors[:grade].should include(error_message)
    end
  end
end
