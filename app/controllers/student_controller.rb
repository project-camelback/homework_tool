class StudentController < ApplicationController

  get '/students' do
    "You are home"
  end

  get '/students/new' do
    # create new student
  end

  get '/students/:id/edit' do
    # edit student info
  end

  get '/students/:id' do
    if @student = Student[params[:id].to_i]
      # erb stuff
    else
      not_found
    end
  end

  post '/students' do
    @student = Student.create(params)
    redirect "/students/#{@student.id}"
  end

  post '/students/:id' do
    if @student = Student[params[:id].to_i]
      @student.update(params.reject{|p| p == :id})
      redirect "/students/#{@student.id}"
    else
      not_found
    end
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