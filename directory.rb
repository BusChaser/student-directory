=begin

# prints names beginning with M only
def print_names(students)
  students.each_with_index do |student, index|
    if student[:name][0] == "M"
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

# prints names if they are less than 12 characters
def print_names(students)
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

# using a while loop
def print_names(students)
  index = 0
  while index < students.size
    puts "#{index + 1}. #{students[index][:name]} (#{students[index][:cohort]} cohort)"
    index += 1
  end
end

def print_names(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]}, #{student[:height]}cm, likes #{student[:hobbies]} (#{student[:cohort]} cohort)".center(80)
  end
end

=end

@students = []

def input_students
  puts "Enter the names of the students"
  puts "Press return twice to finish"
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # prompt for hobbies, height and cohort and read user input
    puts "Enter their hobbies"
    hobbies = gets.slice(0..-2) # exercise 9: alternative to using chomp()
    puts "Enter their height"
    height = gets.chomp
    puts "Enter their cohort month"
    cohort = gets.chomp.downcase

    # create array of valid cohort months to see if the cohort the user entered is valid
    valid_months = ["","january","february","march","april","may","june","july","august","september","october","november","december"]
    until valid_months.include?(cohort)
      puts "Invalid month entered, try again"
      puts "Enter their cohort month"
      cohort = gets.chomp.downcase
    end
    cohort = :default if cohort.empty?

    # add the student hash to the array
    @students << {name: name.capitalize, hobbies: hobbies, height: height.to_i, cohort: cohort.to_sym}
    # print current student total
    puts "Now we have #{@students.count} #{@students.count == 1 ? 'student' : 'students'} "
    # get another name from the user
    puts "Enter another name"
    name = gets.chomp
  end
end 

def print_header
  puts "The students of Villains Academy".center(100)
  puts "------------------------------------".center(100)
end

def print_students_by_cohort
  # make an array of all the cohorts in the student list
  active_cohorts = @students.collect {|student| student[:cohort]}.uniq
  # for each active cohort print the cohort month along with all of its students
  active_cohorts.each do |cohort|
    puts "*** #{cohort.capitalize} cohort ***".center(100)
    @students.each do |student|
      puts "#{student[:name]} is #{student[:height]}cm tall and likes #{student[:hobbies]}.".center(100) if student[:cohort] == cohort
    end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great #{@students.count == 1 ? 'student' : 'students'}".center(100)
end

def print_menu
  puts "--- Menu ---"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
  print "Enter a choice: "
end

def show_students
  print_header()
  print_students_by_cohort()
  print_footer()
end

def process_choice(choice)
  case choice
    when "1"
      input_students()
    when "2"  
      show_students()
    when "9"
      exit
    else
      puts "Invalid choice, try again"
  end
end

def interactive_menu
  loop do
    print_menu()
    process_choice(gets.chomp)
  end
end

# method calls
interactive_menu()