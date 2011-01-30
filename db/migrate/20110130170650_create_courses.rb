class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.integer :student_id, :null => false
      t.integer :subject_id, :null => false
      t.decimal :grade_percentage, :null => false, :default => 1.0, :precision => 4, :scale => 3

      t.timestamps
    end
    
    add_index :courses, :student_id, :unique => false
    add_index :courses, :subject_id, :unique => false
  end

  def self.down
    drop_table :courses
  end
end
