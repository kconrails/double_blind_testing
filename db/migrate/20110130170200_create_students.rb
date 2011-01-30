class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name, :null => false, :limit => 40
      t.integer :grade, :null => false
      t.decimal :gpa, :precision => 4, :scale => 3

      t.timestamps
    end
    
    add_index :students, :name, :unique => false
    add_index :students, :grade, :unique => false
  end

  def self.down
    drop_table :students
  end
end
