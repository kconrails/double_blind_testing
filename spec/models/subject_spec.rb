require 'spec_helper'

describe Subject do
  it "belongs_to a teacher" do
    teacher = Factory.create :teacher

    subject = Subject.new
    subject.teacher.should be_nil
    
    subject.teacher = teacher
    subject.teacher.should == teacher
  end
  
  it {should validate_presence_of :name}
  it {should validate_length_of :name, :maximum => 50, :message => "must be 50 characters or less"}

  it {should validate_presence_of :number}
  
  describe "teacher" do
    it "is present" do
      error_message = "can't be blank"

      teacher = Factory.create(:teacher)
      subject = Factory.create(:subject, :teacher => teacher)
      subject.valid?
      subject.errors[:teacher].should_not include(error_message)
    
      subject.teacher = nil
      subject.should_not be_valid
      subject.errors[:teacher].should include(error_message)
    end
  end
end
