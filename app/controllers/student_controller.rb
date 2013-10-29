class StudentController < ApplicationController

  get '/students' do
    @student = Student.all
    erb :index
  end

  # get '/students/new' do
  #   erb :index
  # end

  get '/students/:id/edit' do
    # edit student info
  end

  get '/students/:github_username' do
      @student = Student.find(:github_username => params[:github_username])
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

  post '/students/:id/destroy' do
    if @student = Student[params[:id].to_i]
      @student.destroy
      redirect "/students"
    else
      not_found
    end
  end

end