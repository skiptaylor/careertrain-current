get '/?' do
	erb :index, layout: false
end

get '/index/?' do
	erb :index, layout: false
end

get '/educator/index/?' do
	erb :'/educator/index'
end

get '/educator/steps/?' do
	erb :'/educator/steps'
end

get '/educator/feedback/?' do
	erb :'/educator/feedback'
end

get '/educator/resources/?' do
	erb :'/educator/resources'
end

get '/contact_us/?' do
	erb :'/contact_us'
end

post '/contact_us/?' do
  params[:email_name].downcase! 
  params[:email_name].strip! 
  if params[:email_name] == "blue"
	
  Pony.mail(
		headers: { 'Content-Type' => 'text/html' },
		to: 'info@careertrain.com, tayloraid@gmail.com',
		from: 'contactUs@careertrain.com',
		subject: "#{params[:subject]}",
		body: "#{markdown params[:msg]}<hr />#{params[:name]}<br />#{params[:email]}"
	)
	redirect '/thanks'
  
  end
end

get '/thanks/?' do
	erb :'/thanks'
end

get '/admin/admin/?' do
	erb :'/admin/admin'
end

get '/about/?' do
	erb :'/about'
end

get '/nac/?' do
	erb :'/nac'
end

get '/arng/arng/?' do
	erb :'/arng/arng'
end

get '/admin/admin_edit/?'  do
  auth_admin
  erb :"/admin/admin_edit"
end

post '/admin/admin/?' do
  if (params[:password].strip.downcase == 'coconutisland')
    session[:admin] = true
    redirect '/admin/admin_edit'
  else
    flash[:alert] = 'Yikes! Try typing that again.'
    redirect '/admin/admin'
  end
end

get '/student/report/scores' do
  erb :'/student/report/scores', layout: false
end

get '/student/resume/resume-view' do
  
  @student = Student.get(session[:student])
  @reference = Reference.all
  erb :'/student/resume/resume-view'
end

get '/student/resume/resume-print' do
  
  @student = Student.get(session[:student])
  erb :'/student/resume/resume-print', layout: false
end

get '/student/resume/resume' do
  
  @student = Student.get(session[:student])
  
  
  content_type 'application/pdf'

     pdf = Prawn::Document.new
     pdf.font "Helvetica"
     pdf.font_size 11
     
     pdf.move_down(11)
     # pdf.text "<b><font size='11px'>Resume</font></b>",
#      :inline_format => true, :leading => 16, :align => :center
     
     pdf.text "<b><font size='13px'>#{@student.first_name} #{@student.middle_name} #{@student.last_name}</font></b>",
     :inline_format => true, :leading => 8
		pdf.text "#{@student.address}
		#{@student.city}, #{@student.state}  #{@student.zip}
		#{formatted_number(@student.phone)}
		#{@student.email}", 
     :inline_format => true, :leading => 1
      
     pdf.move_down(24)
     pdf.text "<b><font size='10px'>Objectives</font></b>",
       :inline_format => true, :leading => 4
     @student.objectives.each do |objective|
       pdf.text "My immediate goal is to work as #{objective.goal}. This will help me learn #{objective.learn}, as I pursue my long-term goal of #{objective.long_goal}."
     end
      
      pdf.move_down(12) 
		  pdf.text "<b><font size='10px'>Career Skills and Accomplishments</font></b>",
      :inline_format => true, :leading => 4
      @student.skills.each do |skill|
        pdf.text "<b>#{skill.skill}</b>",
        :inline_format => true, :indent_paragraphs => 8, :leading => 2
        pdf.text "•  #{skill.applied_1}
        •  #{skill.applied_2}",
        :inline_format => true, :indent_paragraphs => 16, :leading => 2
        pdf.move_down(6)
      end

      pdf.move_down(6)
		  pdf.text "<b><font size='10px'>Education</font></b>",
        :inline_format => true, :leading => 4
      @student.educations.each do |education|
      if education.attending != ""
        pdf.text "Scheduled to graduate from #{education.attending} on #{education.graduate_on}.",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
      if education.plan_attend != ""
        pdf.text "I plan to attend #{education.plan_attend} to study #{education.study}.",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
      if education.completed != ""
        pdf.text "I have completed #{education.completed} on #{education.completed_on}",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
      if education.graduated != ""
        pdf.text "I have graduated from #{education.graduated} on #{education.graduation_date} with a #{education.degree} degree.",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
    end
    
    pdf.move_down(12)
		pdf.text "<b><font size='10px'>Work Experience</font></b>",
      :inline_format => true, :leading => 4
      @student.experiences.each do |experience|
        pdf.text "•  #{experience.company}, #{experience.position}, #{experience.city}, #{experience.state}, #{experience.start} - #{experience.end}",
         :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
    pdf.move_down(12)
		pdf.text "<b><font size='10px'>Activities and Associations</font></b>",
      :inline_format => true, :leading => 4
      @student.activities.each do |activity|
        pdf.text "•  #{activity.position}, #{activity.organization}, #{activity.date_start} - #{activity.date_end}",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
      pdf.move_down(12)
		pdf.text "<b><font size='10px'>Awards and Commendations</font></b>",
      :inline_format => true, :leading => 4
      @student.awards.each do |award|
        pdf.text "•  #{award.award}, #{award.award_date}",
          :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
    pdf.move_down(12)
		pdf.text "<b><font size='10px'>Interests and Hobbies</font></b>",
      :inline_format => true, :leading => 4
			@student.interests.each do |interest|
        pdf.text "•  #{interest.interest}",  
        :inline_format => true, :indent_paragraphs => 8, :leading => 2
      end
    
    pdf.move_down(12)
    
    if @student.references == nil
      
	    pdf.text "<b><i>References available upon request</i></b>", 
      :inline_format => true

    else
			
	    pdf.text "<b><i>References</i></b>", 
      :inline_format => true
      
			@student.references.each do |reference|
			  pdf.move_down(8)
				pdf.text "<b>#{reference.name}</b>",
     :inline_format => true, :leading => 1
        pdf.text "#{reference.relationship}
				#{reference.address}
				#{reference.city} #{reference.state} #{reference.zip}
				#{reference.phone}
				#{reference.email}",
     :inline_format => true, :leading => 1
			
			end
 			
    end
 
    pdf.render
    
 
end

get '/download' do
  send_file 'public/asset/resume.pdf', :type => :pdf
end

get '/student/resume/references/references-view' do
  
  @student = Student.get(session[:student])
  @reference = Reference.get(params[:id])
  erb :'/student/resume/references/references-view'
end

get '/student/resume/letters/letters-view/?' do
  
  @student = Student.get(session[:student])
  @letter = Letter.get(params[:id])
  erb :"/student/resume/letters/letters-view"
end

get '/student/resume/letters/:id/cover-letter' do
  
  @student = Student.get(session[:student])
  @letter = Letter.get(params[:id])
  @objective = Objective.get(params[:id])
  erb :'/student/resume/letters/cover-letter'
end

get '/student/resume/letters/:id/thank-you-letter' do
  
  @student = Student.get(session[:student])
  @letter = Letter.get(params[:id])
  erb :'/student/resume/letters/thank-you-letter'
end


