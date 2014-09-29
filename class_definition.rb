class Dungeon
	attr_accessor :rooms, :inventory #not sure inventory works here...

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

	def get_item # returns item - you need to add to inventory in main loop
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
		direction.upcase!
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
