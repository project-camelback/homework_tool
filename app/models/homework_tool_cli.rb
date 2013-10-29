class HomeworkToolCLI

  COMMANDS =[:help, :exit, :assignments, :new, :evaluate, :submissions]

  def initialize
    @banner_message = "Welcome to HomeworkTool d(-_-)b"
    @prompt         = "#> "   
    @percentage     = 100
  end

  def new
    puts "Create New Assignment"
    puts "====================="
    puts ""

    new_assignment = {
      title: input("Title: "),
      description: input("Description: "),
      post_date: Chronic.parse(input("Post Date: ")),
      due_date: Chronic.parse(input("Due Date: ")),
      url: input("Github URL: "),
      branch: input("Branch: ")
    }

    puts ""

    if ["","y"].include?(input("Save assignment? [Y/n] ").downcase)
      Assignment.create(new_assignment)
    end
  end


  def progress_bar_start

    @width = 60
    Thread.new do
      puts ""
      loop do
        #('-\|/'*10).chars.each do |spin|
        #('┤┘┴└├┌┬┐').chars.each do |spin|
        #('▁▃▄▅▆▇█▇▆▅▄▃').chars.each do |spin|
        #('□▧▣').chars.each do |spin|
        #('ᚆᚇᚈᚉᚊᚉᚈᚇ').chars.each do |spin|
        ('ᚐᚑᚒᚓᚔᚓᚒᚑ').chars.each do |spin|
          length = @percentage*@width/100
          print (" [#{spin*length}".ljust(@width+2," ") + "] #{@percentage}% \r")
          $stdout.flush
          sleep 0.05
        end
        break if @percentage == 100
      end
      print "\n"
      puts ""
    end
    
  end

  def run
    @on=true
    puts @banner_message
    help
      while @on
        process(input)
      end
  end

  def input(prompt = @prompt)
    print prompt 
    gets.chomp.strip
  end

  def assignments
    Assignment.all.each do |assignment|
      puts "#{assignment.id}. #{assignment.title}"
    end
    puts ""
  end

  def submissions
    assignments
    print "Enter assignment ID: " 
    assignment_id = input("").strip
    if assignment = Assignment[assignment_id]
      assignment.assignment_submissions.each do |sub|
        puts "#{sub.student.first_name} #{sub.student.last_name}:"
        puts " └──> Passes: %s  Failures: %s  Pending: %s" % [sub.passes.to_s.green, sub.failures.to_s.red, sub.pendings.to_s.yellow]
      end
    else
      puts "Assignment ID not found!"
    end
  end

  def evaluate
    assignments
    print "Enter assignment ID: " 
    assignment_id = input("").strip
    if assignment = Assignment[assignment_id]
      assignment.pull_submissions
      AssignmentSubmission.evaluate_all(assignment)
      
      @percentage = 0
      progress_bar_start
      while @percentage < 100
        @percentage = AssignmentSubmission.percent_evaluated(assignment)
        sleep 0.05
      end
      sleep 1
      puts ""
      puts "#{assignment.assignment_submissions.count} assignments evaluated."
    else
      puts "Assignment ID not found!"
    end
  end


  def process(input)
    command = input.to_sym
    if command.nil?
      # do nothing
    elsif COMMANDS.include?(command)
      self.send(command) 
    else
      puts "Invalid input. Please try again."
    end
  end

  def help
    puts (["The most commonly used homework tool commands are:",
           "  new            Create a new assignment",
           "  assignments    List all assignments",
           "  submissions    List all submissions",
           "  evaluate       Evaluate all submissions for an assignment",
           "  help           Display the list of accepted commands",
           "  exit           Exit the application"]).join("\n")
  end


  def on?
    @on
  end

  def exit
    puts "Goodbye!"
    @on=false
  end

end
