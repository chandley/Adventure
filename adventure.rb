require './class_definition.rb'	# class definitions for room, item, dungeon etc
require './dungeon_setup.rb' # add_data function for dungeon

def user_input	# returns verb, noun
	# this could use some refactoring
	puts "What would you like to do? Please enter two word command"
	print "> "
	@input_array = gets.chomp.split(' ')
	if @input_array.count == 2
		@verb, @noun = @input_array[0], @input_array[1] # this does not look very neat
	else
		puts "Sorry, didn't understand"
	end
	return @verb, @noun
end



#initialise dungeon
my_dungeon = Dungeon.new
inventory = my_dungeon.rooms[0]
add_data my_dungeon

current_room = my_dungeon.rooms[1]

current_room.describe

#test dungeon
verb, noun = user_input
puts "verb is #{verb}"
puts "noun is #{noun}"
	case 
	when verb == 'go'
		current_room = current_room.move noun	
	when verb == 'get' # get currently picks up random object without noun
		inventory.add_item current_room.get_item
	when verb == 'drop' # drop currently drops random object from inventory
		current_room.add_item inventory.get_item
	when verb == 'show'
		inventory.describe if noun = 'inventory'
	else	
		puts "sorry, didn't understand"		
	end
current_room.describe


#current_room.get_item(0)
#inventory.describe