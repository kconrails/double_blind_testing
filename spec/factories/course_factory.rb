Factory.define :course do |course|
  course.grade_percentage 1.0
  course.student {|student| student.association(:student)}
  course.subject {|subject| subject.association(:subject)}
end