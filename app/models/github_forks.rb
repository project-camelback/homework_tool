class GithubForks

  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def api_url
    "https://api.github.com/repos/#{self.repo.match(/github\.com.(.+)\.git/)[1]}/forks"
  end

  def get_forks
    json = Oj.load(open(api_url, "Authorization" => "token c8893b4ef96cf423f3fe52d01c8f312beb76230e"))
    clones = json.map do |clone|
      { :github_username => clone["owner"]["login"],
        :url => clone["clone_url"]
      }
    end
  end
end