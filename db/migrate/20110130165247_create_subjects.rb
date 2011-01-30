class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name, :limit => 50, :null => false
      t.text :description
      t.integer :number, :null => false
      t.integer :teacher_id, :null => false

      t.timestamps
    end
    
    add_index :subjects, :name, :unique => true
    add_index :subjects, :number, :unique => true
    add_index :subjects, :teacher_id, :unique => false
  end

  def self.down
    drop_table :subjects
  end
end
