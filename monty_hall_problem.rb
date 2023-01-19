require_relative 'door_class.rb'

def verify_input(expected_options)
  attempt = 0
  loop do
    attempt += 1
    input = gets.to_i
    if expected_options.any?{|i| i == input}
      return input 
    end
    if attempt == 3
      raise ArgumentError.new "You selected 3 incorrect option attempts."
    end
    puts "Sorry, you entered an invalid input. Please try again."
  end
end

# Create doors with goats and the car
Door.seed_for_experiment  

# Ask the user to choose one door
puts "Hi, this is a Monty Hall Problem simulator.\nChoose your Door: enter 1, 2 or 3"

# Remember which door the user has chosen
selected_door = Door.find(verify_input([1,2,3])-1)
Door.select(selected_door)


# Determine which (another) door has a goat 
goat_door = Door.find { |d| d.item == :goat && !d.is_selected }
goat_door.unlock # open another door with a goat

# Ask the user to choose the door again
puts "Do you want to change your choice?\nPrint:\n1. [Yes]\n2. [No]"

# Swap the door if the user select "Yes"
if verify_input([1,2]) == 1
  selected_door = Door.find { |d| d.is_open == false && !d.is_selected }
  Door.select(selected_door)
end

# Tell the user whether they win or lose
Door.find_selected.unlock
if Door.find_selected.item == :car
  puts "You win!"
else
  puts "You loose."
end
