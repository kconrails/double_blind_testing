require 'spec_helper'

describe Subject do
  it "belongs_to a teacher" do
    teacher = Factory.create :teacher
    subject = Factory.create(:subject, :teacher => teacher)

    subject.teacher.should == teacher
  end
  
  describe "name" do
    it "is present" do
      subject = Subject.new

      subject.should_not be_valid
      subject.errors[:name].should include("can't be blank")
    end

    it "is at most 50 characters" do
      subject = Subject.new :name => 'x' * 51

      subject.should_not be_valid
      subject.errors[:name].should include("must be 50 characters or less")
    end
  end
  
  describe "number" do
    it "is present" do
      subject = Subject.new

      subject.should_not be_valid
      subject.errors[:number].should include("can't be blank")
    end
  end

  
  describe "teacher" do
    it "is present" do
      subject = Subject.new

      subject.should_not be_valid
      subject.errors[:teacher].should include("can't be blank")
    end
  end
end
