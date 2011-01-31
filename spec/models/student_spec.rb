require 'spec_helper'

describe Student do
  it "has many courses" do
    student = Factory.create :student
    student.courses.should be_empty

    course = student.courses.create Factory.attributes_for(:course)
    student.courses.should include(course)
  end
  
  describe "name" do
    it "is present" do
      error_message = "can't be blank"
      
      student = Student.new :name => 'Joe Example'
      student.valid?
      student.errors[:name].should_not include(error_message)
      
      student.name = nil
      student.should_not be_valid
      student.errors[:name].should include(error_message)
      
      student.name = ''
      student.should_not be_valid
      student.errors[:name].should include(error_message)
    end
    
    it "is at most 50 characters" do
      error_message = "must be 40 characters or less"
      
      student = Student.new :name => 'x' * 40
      student.valid?
      student.errors[:name].should_not include(error_message)
      
      student.name += 'x'
      student.should_not be_valid
      student.errors[:name].should include(error_message)
    end
  end
  
  describe "grade" do
    it "is present" do
      error_message = "can't be blank"
      
      student = Student.new :grade => 1
      student.valid?
      student.errors[:grade].should_not include(error_message)

      student.grade = nil
      student.should_not be_valid
      student.errors[:grade].should include(error_message)

      student.grade = ''
      student.should_not be_valid
      student.errors[:grade].should include(error_message)
    end
    
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
