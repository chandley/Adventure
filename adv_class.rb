class Dungeon
	attr_accessor :rooms, :inventory

	def initialize
		@rooms = []
		@inventory = add_room Room.new "Inventory" #inventory is a special room no exits
	end

	def add_room room
		@rooms.push(room)
	end

end

class Dungeon_thing
	#parent of room, item, monster etc
	def initialize description
		@description = description
	end

	def describe
		puts @description
	end
end

class Room < Dungeon_thing
	def initialize description
		super	
		@exits =  {}	
		@items = []		
	end

	def add_exit direction, room
		@exits[direction] = room
	end

	def add_item item
		@items.push item
	end

	def get_item
		#problem accessing inventory as other room - return item
		@items.pop
	end

	def describe
		super
		@exits.each do |direction,room|
		 	puts "there is an exit #{direction.upcase}"
		end
		@items.each do |item| 
			print "You see "
			item.describe
		end
	end

	def move direction
		if @exits[direction].nil?
			puts "Can't move, try again"
			new_room = self # stay in room if bad exit chosen
		else
			puts "You go #{direction}"
			new_room = @exits[direction]
		end 
	end
end

class Dungeon_item   < Dungeon_thing
	def initialize description , weight
		super(description)
		@weight = weight
	end

	def describe
		print @description, ", weight #{@weight}\n"
	end

end

#initialise dungeon
my_dungeon = Dungeon.new
inventory = my_dungeon.rooms[0]

#set up rooms
my_dungeon.add_room Room.new 'A musty dining room'
my_dungeon.add_room Room.new 'A sunny sitting room'
my_dungeon.add_room Room.new 'A cluttered kitchen'
my_dungeon.add_room Room.new 'A room with no exits'

	# i don't like the way we add exits - is there a better way?
my_dungeon.rooms[1].add_exit 'N', my_dungeon.rooms[2]
my_dungeon.rooms[2].add_exit 'S', my_dungeon.rooms[1]
my_dungeon.rooms[1].add_exit 'W', my_dungeon.rooms[3]
my_dungeon.rooms[3].add_exit 'E', my_dungeon.rooms[1]

#add items
my_dungeon.rooms[3].add_item Dungeon_item.new 'a rusty saucepan' , 10
inventory.add_item Dungeon_item.new 'a boiled sweet covered in pocket fluff', 1

#test dungeon
current_room = my_dungeon.rooms[1]
current_room.describe
current_room = current_room.move 'D'
current_room = current_room.move 'W'
current_room.describe
puts ''
puts ''
inventory.describe
current_room.add_item inventory.get_item
inventory.describe
inventory.add_item current_room.get_item 
inventory.add_item current_room.get_item
inventory.describe

#current_room.get_item(0)
#inventory.describe