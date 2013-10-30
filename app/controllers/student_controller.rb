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

 	get '/admin/eval' do
  	erb :eval
  end

 	get '/admin/submissions' do
  	erb :submissions
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