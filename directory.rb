@students = [] # an empty array accessible to all methods

def print_menu
  puts "\n---- Main Menu ----"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list a file"
  puts "4. Load the list from a file"
  puts "9. Exit" # 9 because we'll be adding more items
  print "\nEnter a choice: "
end

def interactive_menu
  loop do
    print_menu()
    process_choice(STDIN.gets.chomp)
  end
end

def process_choice(choice)
  case choice
    when "1" then input_students()
    when "2" then show_students()
    when "3" then save_students(custom_filename())
    when "4" then load_students(custom_filename())
    when "9" then puts "Aborting ..."; exit()
    else puts "I don't know what you meant, try again"
  end
end

def add_student(name, cohort = :november)
  @students << {name: name.downcase, cohort: cohort.to_sym}
end

def custom_filename
  puts "Enter a file to write to (including extension, e.g. names.txt)"
  puts "To use the default (students.csv) press RETURN"
  STDIN.gets.chomp
end

def input_students
  print "Please enter a name, to finish press RETURN: "
  while !(name = STDIN.gets.chomp).empty?
    add_student(name) # add the student hash to the array
    puts "#{name} was added to the list"
    puts "We now have #{@students.count} student#{'s' if @students.count != 1}"
    print "Please enter a name, to finish press RETURN: "
  end
end

def show_students
  puts "\nPrinting list ..."
  print_header()
  print_student_list()
  print_footer()
end

def print_header
  puts "\nThe Students of Villains Academy"
  puts "----------------------------------"
end

def print_student_list
  @students.each {|student| puts "#{student[:name].capitalize} (#{student[:cohort].to_s.capitalize} cohort)"}
end

def print_footer
  puts "Overall, we have #{@students.count} great student#{'s' if @students.count != 1}\n"
end

def save_students
  # open the file for writing
  
  puts "\nAttempting to write student list to #{filename}"
  file = File.open(filename, "w")
  # iterate over the array of students, write a line to the file containing the student's info seperated by a comma
  @students.each {|student| file.puts [student[:name], student[:cohort]].join(",")}
  file.close
  puts "File write successful"
end

def load_students(filename = "students.csv")
  puts "Attempting to load student list from #{filename} ..."

  if !File.exists?(filename)
    puts "Failed to load, file doesn't exist"
    return
  elsif File.zero?(filename)
    puts "Failed to load, file is empty"
    return
  else
    file = File.open(filename, "r")
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      add_student(name, cohort)
    end
  end

  file.close
  puts "Loaded #{@students.count} from #{filename}"
end

load_students(ARGV.first if !ARGV.first.nil?)
interactive_menu()