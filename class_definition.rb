#### setup class
class Dungeon_thing  
	attr_accessor :description, :long_description
	def initialize (description, long_description)
		@description = description
		@long_description = long_description # default value
	end
end

class Room < Dungeon_thing 
	attr_accessor :exits, :items, :monsters
	def initialize (description, long_description)
		super description, long_description
		@exits = {}	
		@items = []
		@monsters = []
	end

	def long_description #override accessor to show exits
		return_string = ''
		return_string << @long_description + "\n"
		@exits.each {|direction,room| return_string <<"there is an exit #{direction.upcase} to #{room.description}\n" } unless @exits.keys.count == 0
		@items.each {|item|  return_string << "you see item #{item.description}\n"}
		@monsters.each {|monster| return_string << "you see monster #{monster.description}\n"}
		return return_string
	end
end

class Item < Dungeon_thing
end

class Monster < Dungeon_thing
end

#### functions
def user_input (prompt)# returns verb, noun
	# this could use some refactoring
	puts prompt
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

###### setup dungeon
kitchen = Room.new 'kitchen', 'A cluttered kitchen, light streams in through the window'
dining = Room.new 'dining room',  'A dusty dining room. A fly buzzes around'
inventory = Room.new 'inventory', 'You are carrying the following'

kitchen.exits['N'] = dining
dining.exits['S'] = kitchen

toast = Item.new 'toast', 'A piece of buttered toast'
hobgoblin = Monster.new 'Hobgoblin', 'A nasty looking goblin'

empty_gun = Item.new 'unloaded gun','an automatic pistol, it contains no bullets'
bullets = Item.new 'some bullets', 'some bullets. these look as if they will fit in the gun'

kitchen.items.push toast
kitchen.monsters.push hobgoblin

dining.items.push empty_gun
dining.items.push bullets

##### test dungeon

current_room = kitchen	

loop do 
  puts current_room.long_description
  verb, noun = user_input "please enter instruction (verb, noun)"
    case verb
	when  'move'
	  	current_room = current_room.exits[noun.upcase[0]] # use first character only
	  	puts "You go #{noun.upcase} to #{current_room.description}"
	when  'inventory'
	  	inventory.long_description
	when  'get' 	
	  	item = inventory.items.push current_room.items.pop
	  	puts "you pick up #{item.last.description}"
	when  'drop'
		item = current_room.items.push inventory.items.pop
	  	puts "you drop {item.last.description}"	  	
  	end	
end





