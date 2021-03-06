# Clear out all the current data
DataMapper.repository(:default).adapter.execute("delete from educations")

CSV.open('./data/ct_resume_databases/education.csv', { headers: true }) do |csv_lines|
  csv_lines.each do |line|
    Education.create(
      student_id:             line['ID'].to_i,
      id:                     line['ID_PK'].to_i,
      attending:              line['Attending'],
      graduate_on:            line['Graduate_On'],
      plan_attend:            line['Plan_attend'],
      completed:              line['Completed'],
      completed_on:           line['Completed_On'],
      graduated:              line['Graduated'],
      graduation_date:        line['Graduation_Date'],
      study:                  line['Study'],
      degree:                 line['Degree_Recieved']
    )
  end
end
