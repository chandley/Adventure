
class Dungeon_thing  
	attr_accessor :description, :long_description
	def initialize (description)
		@description = description
		@long_descripton = description # default value
	end

end

class Room < Dungeon_thing 
	attr_accessor :exits
	def initialize (description)
		super (description)
		@exits = {}		
	end

	def add_exit direction, room
		@exits[direction] = room
	end

	def long_description #override accessor
		puts @long_description
		@exits.each {|direction,room| puts "there is an exit #{direction.upcase} to #{room.description}" }
	end
#		@items.each { |item| print "You see " item.describe
#		end
	

end

my_room = Room.new ('kitchen' )
my_room.long_description = 'A cluttered kitchen, light streams in through the window'

your_room = Room.new ('dining room')
your_room.long_description = 'A dusty dining room. Ivy is growing through the window'
my_room.exits['N'] = your_room
your_room.exits['S'] = my_room

current_room = my_room
puts current_room.long_description

current_room = current_room.exits['N']
puts current_room.long_description




