# Clear out all the current data
DataMapper.repository(:default).adapter.execute("delete from objectives")

CSV.open('./data/ct_resume_databases/career_objective.csv', { headers: true }) do |csv_lines|
  csv_lines.each do |line|
    Objective.create(
      student_id: line['ID'].to_i,
      goal:       line['Goal'],
      learn:      line['Learn'],
      long_goal:  line['Long_Goal'],
      id:         line['ID_PK'].to_i
    )
  end
end
