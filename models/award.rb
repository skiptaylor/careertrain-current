class Award
	include DataMapper::Resource

	timestamps :at, :on
	property   :deleted_at, ParanoidDateTime
	property 	 :id, 				Serial

  property :student_id,  Integer
  property :award,  String
  property :award_date, Date
  property :award_date_change, Date
  
  belongs_to :student, required: false
  
end