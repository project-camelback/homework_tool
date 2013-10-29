class HomeworkToolCLI

  COMMANDS =[:help, :exit, :assignments, :new, :evaluate, :submissions]

  def initialize
    @banner_message = "Welcome to HomeworkTool d(-_-)b"
    @prompt         = "#> "    
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
    gets.chomp.strip.downcase
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
        puts " └──> Passes: %s  Failures: %s  Pending: %s" % [sub.passes.to_s.red, sub.failures.to_s.green, sub.pendings.to_s.yellow]
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
      # TODO: Progress bar
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
    puts (["The most commonly used Jukebox commands are:",
           "   play <song|index>  Play specified song",
           "   list               List all songs that can be played",
           "   help               Display the list of accepted commands",
           "   exit               Exit the jukebox application"]).join("\n")
  end


  def on?
    @on
  end

  def exit
    puts "Goodbye!"
    @on=false
  end

end
