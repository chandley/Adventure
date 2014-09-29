def add_data (dungeon)

	#set up rooms
	dungeon.add_room Room.new 'A musty dining room'
	dungeon.add_room Room.new 'A sunny sitting room'
	dungeon.add_room Room.new 'A cluttered kitchen'
	dungeon.add_room Room.new 'A room with no exits'

	# i don't like the way we add exits - is there a better way?
	dungeon.rooms[1].add_exit 'N', dungeon.rooms[2]
	dungeon.rooms[2].add_exit 'S', dungeon.rooms[1]
	dungeon.rooms[1].add_exit 'W', dungeon.rooms[3]
	dungeon.rooms[3].add_exit 'E', dungeon.rooms[1]

	#add items
	dungeon.rooms[3].add_item Dungeon_item.new 'a rusty saucepan' , 10
	dungeon.rooms[0].add_item Dungeon_item.new 'a boiled sweet covered in pocket fluff', 1
	#my_dungeon.inventory.add_item Dungeon_item.new 'a boiled sweet covered in pocket fluff', 1 #this doesn't work - why?
end

def add_data2 (dungeon)
	#setup for makers academy dungeon - not yet used
	#set up rooms
	dungeon.add_room Room.new 'Street outside office'
	dungeon.add_room Room.new 'The lobby of 25 city road'
	dungeon.add_room Room.new 'Lift, ground floor'
	dungeon.add_room Room.new 'Lift, floor 4'
	dungeon.add_room Room.new 'Landing, floor 4'
	dungeon.add_room Room.new 'Reception of Makers Academy'



		# i don't like the way we add exits - is there a better way?
	dungeon.rooms[1].add_exit 'E', dungeon.rooms[2]
	dungeon.rooms[2].add_exit 'W', dungeon.rooms[1]
	dungeon.rooms[2].add_exit 'E', dungeon.rooms[3]
	dungeon.rooms[3].add_exit 'W', dungeon.rooms[2]
	dungeon.rooms[3].add_exit 'U', dungeon.rooms[4]
	dungeon.rooms[4].add_exit 'D', dungeon.rooms[3]
	dungeon.rooms[4].add_exit 'W', dungeon.rooms[5]
	dungeon.rooms[5].add_exit 'E', dungeon.rooms[4]
	dungeon.rooms[5].add_exit 'W', dungeon.rooms[6]
	dungeon.rooms[6].add_exit 'E', dungeon.rooms[5]

	#add items
	dungeon.rooms[1].add_item Dungeon_item.new 'a cigarette end' , 1
	dungeon.rooms[2].add_item Dungeon_item.new 'a security guard' , 100
	dungeon.rooms[6].add_item Dungeon_item.new 'a sticker' , 2
	dungeon.rooms[0].add_item Dungeon_item.new 'a boiled sweet covered in pocket fluff', 1
	#my_dungeon.inventory.add_item Dungeon_item.new 'a boiled sweet covered in pocket fluff', 1 #this doesn't work - why?
end