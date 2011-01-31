require 'spec_helper'

describe Teacher do
  it "has many subjects" do
    teacher = Factory.create :teacher
    subject = teacher.subjects.create Factory.attributes_for(:subject)

    teacher.subjects.should include(subject)
  end
  
  describe "name" do
    it "is present" do
      teacher = Teacher.new

      teacher.should_not be_valid
      teacher.errors[:name].should include("can't be blank")
    end
    
    it "is at most 50 characters" do
      teacher = Teacher.new :name => 'x' * 51
      
      teacher.should_not be_valid
      teacher.errors[:name].should include("must be 50 characters or less")
    end
  end
  
  describe "salary" do
    it "is present" do
      teacher = Teacher.new

      teacher.should_not be_valid
      teacher.errors[:salary].should include("can't be blank")
    end
    
    it "is at or above $20K" do
      teacher = Teacher.new :salary => 19999.99

      teacher.should_not be_valid
      teacher.errors[:salary].should include("must be between $20K and $100K")
    end
    
    it "is no more than $100K" do
      teacher = Teacher.new :salary => 100_000.01
      
      teacher.should_not be_valid
      teacher.errors[:salary].should include("must be between $20K and $100K")
    end
  end
end
