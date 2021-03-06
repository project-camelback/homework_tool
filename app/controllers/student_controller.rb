class StudentController < ApplicationController

  get '/students' do
    @student = Student.all
    erb :index
  end

  get '/students/:id/edit' do
    # edit student info
  end

  get '/assignments/new' do
    erb :new
  end

  post '/assignments' do
    redirect '/admin'
  end

  get '/admin' do
    erb :admin
  end

  get '/students/:github_username' do
    @student = Student.find(:github_username => params[:github_username])
    @assignment_array = Assignment.order(:due_date)
    @total_passes = 0
    @student.assignment_submissions.each {|s| @total_passes += s.passes}
    @total_pendings = 0
    @student.assignment_submissions.each {|s| @total_pendings += s.pendings}
    @total_failures = 0
    @student.assignment_submissions.each {|s| @total_failures += s.failures}
    @total = @total_passes + @total_pendings + @total_failures
    @pass_percent = @total_passes.to_f/@total * 100
    @pending_percent = @total_pendings.to_f/@total * 100
    @failure_percent = @total_failures.to_f/@total * 100
    erb :show
  end

  post '/assignment_submissions/' do
    Assignment.all.each { |assignment| assignment.pull_submissions}
    redirect "/students/#{params[:github_username]}"

  end

  post '/assignment_submissions/:id' do
    assignment_submission = AssignmentSubmission[params[:id]]
    assignment_submission.evaluate
    redirect "/students/#{assignment_submission.student.github_username}"
  end

  post '/students' do
    @student = Student.create(params)
    redirect "/students/#{@student.id}"
  end

  # post '/students/:id' do
  #   if @student = Student[params[:id].to_i]
  #     @student.update(params.reject{|p| p == :id})
  #     redirect "/students/#{@student.id}"
  #   else
  #     not_found
  #   end
  # end

	get '/admin/new' do
  	erb :new
  end

  get '/admin' do
  	erb :admin
  end

 	get '/admin/assignments' do
 		@assignments = Assignment.all
  	erb :assignments
  end

  post '/admin/assignments' do
    params[:assignment][:post_date] = Chronic.parse(params[:assignment][:post_date])
    params[:assignment][:due_date] = Chronic.parse(params[:assignment][:due_date])
  	@assignment = Assignment.create(params[:assignment])
  	redirect "/admin/assignments"
  end

# evaluate button works but have error: 
# No such file or directory - tmp/kyleshike/.rspec-results.json 
  post '/admin/assignments/evaluate' do
    assignment = Assignment[params[:id]]
    AssignmentSubmission.evaluate_all(assignment)
    redirect "/admin/assignments/#{params[:id]}/submissions"
  end

   post '/admin/assignments/:id/pullforks' do
    assignment = Assignment[params[:id]]
    assignment.pull_submissions
    redirect "/admin/assignments/#{params[:id]}/submissions"
  end

 	get '/admin/assignments/:id/submissions' do
 		@assignment = Assignment[params[:id].to_i]
  	erb :submissions
  end

  post '/admin/assignments/:id/submissions' do
  	redirect "/admin/assignments/#{params[:id]}/submissions"
  end

  post '/students/:id/destroy' do
    if @student = Student[params[:id].to_i]
      @student.destroy
      redirect "/students"
    else
      not_found
    end
  end

end