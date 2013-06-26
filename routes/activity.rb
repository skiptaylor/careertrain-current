get '/student/resume/activities/?' do
  @student = Student.get(session[:student])
	@activity = Activity.all
	erb :'/student/resume/activities'
end

get '/student/resume/activities/new/?' do
  @student = Student.get(session[:student])
  @activity = Activity.new
  erb :'/student/resume/activities/edit'
end

post '/student/resume/activities/new/?' do
  activity = Activity.create(
    :position           => params[:position],
    :organization       => params[:organization],
    :date_start         => params[:date_start],
    :date_end           => params[:date_end],
    :student_id         => session[:student],
    :date_start_change  => params[:date_start_change],
    :date_end_change    => params[:date_end_change]
  )
  redirect '/student/resume/activities/activities'
end

get '/student/resume/activities/activities/?' do
  @student = Student.get(session[:student])
  @activity = Activity.get(params[:id])
  erb :'/student/resume/activities/activities'
end


get '/student/resume/activities/:id/view/?' do
  @student = Student.get(session[:student])
  @activity = Activity.get(params[:id])
  erb :'/student/resume/activities/view'
end

get '/student/resume/activities/:id/edit/?' do
  @student = Student.get(session[:student])
  @activity = Activity.get(params[:id])
  erb :'/student/resume/activities/edit'
end

post '/student/resume/activities/:id/edit/?' do
  @student = Student.get(session[:student])
  activity = Activity.get(params[:id])
  activity.update(
  :position           => params[:position],
  :organization       => params[:organization],
  :date_start         => params[:date_start],
  :date_end           => params[:date_end],
  :student_id         => session[:student],
  :date_start_change  => params[:date_start_change],
  :date_end_change    => params[:date_end_change]
    
  )
  redirect '/student/resume/activities/activities'
end

get '/student/resume/activities/:id/delete/?' do
  @student = Student.get(session[:student])
  activity = Activity.get(params[:id])
  activity.destroy
  redirect '/student/resume/activities/activities'
end
