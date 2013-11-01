##homework-tool
*thanks for using aspen - happy coding!*

curl -i -H 'Authorization: token c8893b4ef96cf423f3fe52d01c8f312beb76230e' https://api.github.com/repos/flatiron-school/rps-game-app/forks | grep clone_url

Oj - JSON Gem
github = open(https://api.github.com/repos/flatiron-school/#{assignment_name}/forks)
json_stuff = json.parse(github)
json_stuff[:clone_url]
json_stuff[:owner][:login]


## Models

GitHubForks
* get_clones

AssignmentSubmission
* run
* passes
* fails
* coverage

RSpecChecker
* self.run


TODO
* Load new assignments automatically via ".assignment" file in root of repo
* Configure version of ruby to be used for testing (rvm)
* contineous integrations - let GitHub notify us about assignment or student repo changes
* SimpleCov integration
* TravisCI like badge for student repro
* Commonly failed tests
* Replace grader.sh with pure ruby code
* Build and use VirtualBox image for grading
* Create HTTP API

https://github.com/rails/rails-dev-box
http://downloads.vagrantup.com/tags/v1.3.5