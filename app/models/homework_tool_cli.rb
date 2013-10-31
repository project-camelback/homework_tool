class HomeworkToolCLI

  COMMANDS =[:help, :exit, :assignments, :new, :evaluate, :submissions, :p, :s, :e, :a]

  def initialize
    @banner_message = " "*8 + "*****".red + "  Welcome to HomeworkTool d(-_-)b  ".green + "*****".red
    @prompt         = "#> "   
    @percentage     = 100
  end

  def new
    puts ""
    puts "Create New Assignment".yellow
    puts "====================="
    puts ""

    new_assignment = {
      title: input("Title: ".green),
      description: input("Description: ".green),
      post_date: Chronic.parse(input("Post Date: ".green)),
      due_date: Chronic.parse(input("Due Date: ".green)),
      url: input("Github URL: ".green),
      branch: input("Branch: ".green)
    }

    puts ""

    if ["","y"].include?(input("Save assignment? [#{'Y'.green}/#{'n'.red}] ").downcase)
      Assignment.create(new_assignment)
    end
    puts ""
  end

  def p
    @percentage = 0
    progress_bar_start
    sleep 5
    (1..100).each do |per|
      @percentage = per
      sleep 0.08
    end
    sleep 1
  end

  def progress_bar_start

    @width = 60
    Thread.new do
      puts ""
      loop do
        progress_length = @percentage*@width/100
        if @percentage == 0
          4.times do |dots|
            print (" [" + ("Loading#{'.'*dots}".ljust(10).center(@width)) + "] #{@percentage}%    \r")
            sleep 0.2
          end
        else
          ('ᚐᚑᚒᚓᚔᚓᚒᚑ').chars.each do |spin|
            print (" [#{spin*progress_length}".ljust(@width+2," ") + "] #{@percentage}%    \r")
            $stdout.flush
            sleep 0.02
          end
        end
        break if @width == progress_length
      end
      print "\n"
      puts ""
    end
    
  end

  def run
    system "clear"
    @on=true
    puts ""
    puts @banner_message
    puts ""
    help
      while @on
        process(input)
      end
  end

  def input(prompt = @prompt)
    print prompt 
    gets.chomp.strip
  end
  def a
    assignments
  end
  def assignments
    puts ""
    puts "Assignments".yellow
    puts "==========="
    puts ""
    Assignment.all.each do |assignment|
      puts "#{assignment.id}. #{assignment.title}"
    end
    puts ""
  end
  def s
    submissions
  end
  def submissions
    assignments
    assignment_id = input("Enter assignment ID: ".green).strip
    if assignment = Assignment[assignment_id]
      puts ""
      puts assignment.title.yellow
      puts "="*(assignment.title.length)
      puts ""

      assignment.assignment_submissions.each do |sub|
        puts "#{sub.student.first_name} #{sub.student.last_name}:"
        puts " └──> Passes: %s  Failures: %s  Pending: %s" % [sub.passes.to_s.green, sub.failures.to_s.red, sub.pendings.to_s.yellow]
      end
    else
      puts "Assignment ID not found!".red
    end
  end
  def e
    evaluate
  end
  def evaluate
    assignments
    assignment_id = input("Enter assignment ID: ".green).strip
    if assignment = Assignment[assignment_id]
      assignment.pull_submissions
      AssignmentSubmission.evaluate_all(assignment)
      
      @percentage = 0
      progress_bar_start
      while @percentage < 100
        @percentage = AssignmentSubmission.percent_evaluated(assignment)
        sleep 0.02
      end
      sleep 1
      puts ""
      puts "#{assignment.assignment_submissions.count} assignments evaluated."
    else
      puts "Assignment ID not found!".red
    end
  end


  def process(input)
    command = input.to_sym
    if command.nil?
      # do nothing
    elsif COMMANDS.include?(command)
      self.send(command) 
    else
      puts "Invalid input. Please try again.".red
    end
  end

  def help
    puts ""
    puts (["  The most commonly used homework tool commands are:", "",
           "      new            Create a new assignment",
           "      assignments    List all assignments",
           "      submissions    List all submissions",
           "      evaluate       Evaluate all submissions for an assignment",
           "      help           Display the list of accepted commands",
           "      exit           Exit the application", "", ""]).join("\n")
    puts ""
  end


  def on?
    @on
  end

  def exit
    puts "Goodbye!"
    @on=false
  end

end
