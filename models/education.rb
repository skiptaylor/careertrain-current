class Education
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :student_id,  Integer
  property :attending,  String
  property :graduate_on, Date
  property :plan_attend, String
  property :completed, String
  property :completed_on, Date
  property :graduated, String
  property :graduation_date, Date
  property :study, String
  property :grad_date_change, Date
  property :completed_date_change, Date
  property :graduation_date_change, Date
  property :degree, String
  
  belongs_to :student, required: false
  
end