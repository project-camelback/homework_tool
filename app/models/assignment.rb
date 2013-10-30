class Assignment < Sequel::Model

  one_to_many :assignment_submissions

  def pull_submissions
    github_fork = GithubForks.new(self.url)
    github_fork.get_forks.each do |fork|
      student = Student.find_or_create(:github_username => fork[:github_username])
      student.update(:avatar_url => fork[:avatar_url])
      unless AssignmentSubmission.find(:student => student, :assignment => self)
        self.add_assignment_submission(:url => fork[:url], :student => student)
      end
    end
  end

end