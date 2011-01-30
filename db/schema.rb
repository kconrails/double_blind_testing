# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110130170650) do

  create_table "courses", :force => true do |t|
    t.integer  "student_id",                                                      :null => false
    t.integer  "subject_id",                                                      :null => false
    t.decimal  "grade_percentage", :precision => 4, :scale => 3, :default => 1.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["student_id"], :name => "index_courses_on_student_id"
  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"

  create_table "students", :force => true do |t|
    t.string   "name",       :limit => 40,                               :null => false
    t.integer  "grade",                                                  :null => false
    t.decimal  "gpa",                      :precision => 4, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["grade"], :name => "index_students_on_grade"
  add_index "students", ["name"], :name => "index_students_on_name"

  create_table "subjects", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.text     "description"
    t.integer  "number",                    :null => false
    t.integer  "teacher_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["name"], :name => "index_subjects_on_name", :unique => true
  add_index "subjects", ["number"], :name => "index_subjects_on_number", :unique => true
  add_index "subjects", ["teacher_id"], :name => "index_subjects_on_teacher_id"

  create_table "teachers", :force => true do |t|
    t.string   "name",       :limit => 50,                                :null => false
    t.decimal  "salary",                   :precision => 10, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["name"], :name => "index_teachers_on_name"

end
