class School

  def initialize
    @school = Hash.new { |h, k| h[k] = [] }
  end

  def to_hash
    Hash[@school.sort_by { |grade, students| [grade, students.sort!] }]
  end

  def add(student, grade)
    @school[grade] << student
  end

  def grade(grade_num)
    @school[grade_num].sort
  end

end
