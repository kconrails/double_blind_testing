require 'spec_helper'

describe Subject do
  it "belongs_to a teacher" do
    teacher = Factory.create :teacher

    subject = Subject.new
    subject.teacher.should be_nil
    
    subject.teacher = teacher
    subject.teacher.should == teacher
  end
  
  describe "name" do
    it "is present" do
      error_message = "can't be blank"
      
      subject = Subject.new :name => 'Joe Example'
      subject.valid?
      subject.errors[:name].should_not include(error_message)

      subject.name = nil
      subject.should_not be_valid
      subject.errors[:name].should include(error_message)

      subject.name = ''
      subject.should_not be_valid
      subject.errors[:name].should include(error_message)
    end

    it "is at most 50 characters" do
      error_message = "must be 50 characters or less"
      subject = Subject.new :name => 'x' * 50
      subject.valid?
      subject.errors[:name].should_not include(error_message)

      subject.name += 'x'
      subject.should_not be_valid
      subject.errors[:name].should include(error_message)
    end
  end
  
  describe "number" do
    it "is present" do
      error_message = "can't be blank"

      subject = Subject.new :number => 240
      subject.valid?
      subject.errors[:number].should_not include(error_message)

      subject.number = nil
      subject.should_not be_valid
      subject.errors[:number].should include(error_message)

      subject.number = ''
      subject.should_not be_valid
      subject.errors[:number].should include(error_message)
    end
  end

  
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
