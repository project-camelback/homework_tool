class HomeworkToolCLI

  COMMANDS =[:help, :exit, :assignments, :new, :evaluate, :submissions, :progress]



  def progress

    @show_progress_bar = true

    Thread.new do
      puts ""
      (0..50).to_a.each do |percentage|
        #('-\|/'*10).chars.each do |spin|
        #('┤┘┴└├┌┬┐').chars.each do |spin|
        #('▁▃▄▅▆▇█▇▆▅▄▃').chars.each do |spin|
        #('□▧▣').chars.each do |spin|
        #('ᚆᚇᚈᚉᚊᚉᚈᚇ').chars.each do |spin|
        ('ᚐᚑᚒᚓᚔᚓᚒᚑ').chars.each do |spin|
          print (" [#{spin*percentage}".ljust(52," ") + "] #{percentage*2}% \r")
          $stdout.flush
          sleep 0.05
        end
        break unless @show_progress_bar
      end
      print "\n"
      puts ""
    end
  
    sleep 30
    @show_progress_bar = false

  end


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
        puts " └──> Passes: %s  Failures: %s  Pending: %s" % [sub.passes, sub.failures, sub.pendings]
        puts ""
      end
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
