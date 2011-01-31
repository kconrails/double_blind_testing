require 'spec_helper'

describe Course do
  it "belongs to a student" do
    student = Factory.create :student
    course = Factory.create(:course, :student => student)

    course.student.should == student
  end
  
  it "belongs to a subject" do
    subject = Factory.create :subject
    course = Factory.create(:course, :subject => subject)

    course.subject.should == subject
  end
  
  describe "student" do
    it "is present" do
      course = Course.new

      course.should_not be_valid
      course.errors[:student].should include("can't be blank")
    end
  end
  
  describe "subject" do
    it "is present" do
      course = Course.new

      course.should_not be_valid
      course.errors[:subject].should include("can't be blank")
    end
  end
  
  describe "grade_percentage" do
    it "defaults to 1.0" do
      course = Course.new
      course.grade_percentage.should == 1.0
    end
  end
end
