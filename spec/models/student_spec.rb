require 'spec_helper'

describe Student do
  it "has many courses" do
    student = Factory.create :student
    course = student.courses.create Factory.attributes_for(:course)

    student.courses.should include(course)
  end
  
  describe "name" do
    it "is present" do
      student = Student.new

      student.should_not be_valid
      student.errors[:name].should include("can't be blank")
    end
    
    it "is at most 50 characters" do
      student = Student.new :name => 'x' * 41
      
      student.should_not be_valid
      student.errors[:name].should include("must be 40 characters or less")
    end
  end
  
  describe "grade" do
    it "is present" do
      student = Student.new

      student.should_not be_valid
      student.errors[:grade].should include("can't be blank")
    end
    
    it "should be at least 9" do
      student = Student.new :grade => 8
      
      student.should_not be_valid
      student.errors[:grade].should include("must be between 9 and 12")
    end
    
    it "should be at most 12" do
      student = Student.new :grade => 13
      
      student.should_not be_valid
      student.errors[:grade].should include("must be between 9 and 12")
    end
  end
end
