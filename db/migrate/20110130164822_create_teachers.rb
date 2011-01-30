class CreateTeachers < ActiveRecord::Migration
  def self.up
    create_table :teachers do |t|
      t.string :name, :limit => 50, :null => false
      t.decimal :salary, :null => false, :precision => 10, :scale => 2

      t.timestamps
    end
    
    add_index :teachers, :name
  end

  def self.down
    drop_table :teachers
  end
end
