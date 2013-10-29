require_relative '../config/environment'

assignment = Assignment.create(:branch => 'solution')
github_fork = GithubForks.new("git@github.com:flatiron-school/sinatra-rspec-intro-ruby-003.git")
github_fork.get_forks.each do |fork|
  student = Student.find_or_create(:github_username => fork[:github_username])
  unless AssignmentSubmission.find(:student => student, :assignment => assignment)
    assignment.add_assignment_submission(:url => fork[:url], :student => student)
  end
end
assignment.assignment_submissions.each do |sub|
  system("ruby bin/evaluate.rb #{sub.id}")
end

# cli
# student pages
# admin pages