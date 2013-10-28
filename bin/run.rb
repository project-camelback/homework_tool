require_relative '../config/environment'

assignment = Assignment[1]
# github_fork = GithubForks.new("https://github.com/flatiron-school/rps-game-app.git")
# github_fork.get_forks.each do |fork|
#   student = Student.find_or_create(:github_username => fork[:github_username])
#   unless AssignmentSubmission.find(:student => student, :assignment => assignment)
#     assignment.add_assignment_submission(:url => fork[:url], :student => student)
#   end
# end
AssignmentSubmission.evaluate_all(assignment)