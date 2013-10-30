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
      @assignment_array = Assignment.all
      binding.pry
      #SELECT * FROM assignment_submissions 
      #WHERE student_id = #{actualstudentid} AND assignment_id == 5
      erb :show
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