require 'spec_helper'

describe Teacher do
  it "has many subjects" do
    teacher = Factory.create :teacher
    teacher.subjects.should be_empty

    subject = teacher.subjects.create Factory.attributes_for(:subject)
    teacher.subjects.should include(subject)
  end
  
  describe "name" do
    it "is present" do
      error_message = "can't be blank"
      
      teacher = Teacher.new :name => 'Joe Example'
      teacher.valid?
      teacher.errors[:name].should_not include(error_message)

      teacher.name = nil
      teacher.should_not be_valid
      teacher.errors[:name].should include(error_message)

      teacher.name = ''
      teacher.should_not be_valid
      teacher.errors[:name].should include(error_message)
    end
    
    it "is at most 50 characters" do
      error_message = "must be 50 characters or less"
      
      teacher = Teacher.new :name => 'x' * 50
      teacher.valid?
      teacher.errors[:name].should_not include(error_message)
      
      teacher.name += 'x'
      teacher.should_not be_valid
      teacher.errors[:name].should include(error_message)
    end
  end
  
  describe "salary" do
    it "is present" do
      error_message = "can't be blank"
      
      teacher = Teacher.new :salary => 1
      teacher.valid?
      teacher.errors[:salary].should_not include(error_message)

      teacher.salary = nil
      teacher.should_not be_valid
      teacher.errors[:salary].should include(error_message)

      teacher.salary = ''
      teacher.should_not be_valid
      teacher.errors[:salary].should include(error_message)
    end
    
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
