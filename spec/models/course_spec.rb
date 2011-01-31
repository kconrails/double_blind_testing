require 'spec_helper'

describe Course do
  it "belongs to a student" do
    student = Factory.create :student

    course = Course.new
    course.student.should be_nil
    
    course.student = student
    course.student.should == student
  end
  
  it "belongs to a subject" do
    subject = Factory.create :subject

    course = Course.new
    course.subject.should be_nil
    
    course.subject = subject
    course.subject.should == subject
  end
  
  describe "student" do
    it "is present" do
      error_message = "can't be blank"
      
      student = Factory.create :student
      course = Factory.create :course, :student => student
      course.valid?
      course.errors[:student].should_not include(error_message)

      course.student = nil
      course.should_not be_valid
      course.errors[:student].should include(error_message)
    end
  end
  
  describe "subject" do
    it "is present" do
      error_message = "can't be blank"
      
      subject = Factory.create :subject
      course = Factory.create :course, :subject => subject
      course.valid?
      course.errors[:subject].should_not include(error_message)
      
      course.subject = nil
      course.should_not be_valid
      course.errors[:subject].should include(error_message)
    end
  end
  
  describe "grade_percentage" do
    it "defaults to 1.0" do
      course = Course.new :grade_percentage => nil
      course.grade_percentage.should be_nil
      
      course = Course.new :grade_percentage => ''
      course.grade_percentage.should be_blank
      
      course = Course.new :grade_percentage => 0.95
      course.grade_percentage.should == 0.95
      
      course = Course.new
      course.grade_percentage.should == 1.0
    end
  end
end
