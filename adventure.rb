require './class_definition.rb'	# class definitions for room, item, dungeon etc
require './dungeon_setup.rb' # add_data function for dungeon

def user_input	# returns verb, noun
	# this could use some refactoring
	puts "What would you like to do? Please enter two word command"
	print "> "
	@input_array = gets.chomp.split(' ')
	@verb, @noun = 'default', 'default'  # might be better off with nil as default values
	if @input_array.count == 2
		@verb, @noun = @input_array[0], @input_array[1] # this does not look very neat
	else
		puts "Sorry, didn't understand"
	end
	return @verb.downcase, @noun.downcase
end



#initialise dungeon
my_dungeon = Dungeon.new
inventory = my_dungeon.rooms[0]
add_data2 my_dungeon
current_room = my_dungeon.rooms[1]

#test dungeon
(0..10).each do #test loop few times
	current_room.describe
	puts ''
	verb, noun = user_input
	puts "verb is #{verb}, noun is #{noun}" # for debugging
	case 
		when verb == 'go'
			current_room = current_room.move noun
			puts "you went #{noun}"	
		when verb == 'get' # get currently picks up random object without noun
			inventory.add_item current_room.get_item
			puts 'you picked something up'
		when verb == 'drop' # drop currently drops random object from inventory
			current_room.add_item inventory.get_item
			puts 'you dropped something'
		when verb == 'show'
			inventory.describe if noun == 'inventory' 
		when verb == 'quit'
			puts 'bye'
			break	
		else	
			puts "sorry, didn't understand"		
	end
	puts ''
end



#current_room.get_item(0)
#inventory.describe