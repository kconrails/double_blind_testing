Factory.define :subject do |subject|
  subject.sequence(:name) {|i| "Subject #{i}"}
  subject.sequence(:number) {|i| 200 + i}
  subject.teacher {|teacher| teacher.association(:teacher)}
end