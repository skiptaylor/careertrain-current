# Clear out all the current data
DataMapper.repository(:default).adapter.execute("delete from awards")

CSV.open('./data/ct_resume_databases/awards.csv', { headers: true }) do |csv_lines|
  csv_lines.each do |line|
    Award.create(
      student_id:         line['ID'].to_i,
      id:                 line['ID_PK'].to_i,
      award:              line['Award'],
      award_date:         line['Award_Date']
    )
  end
end
