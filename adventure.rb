require './class_definition.rb'	# class definitions for room, item, dungeon etc
require './dungeon_setup.rb' # add_data function for dungeon


#initialise dungeon
my_dungeon = Dungeon.new
inventory = my_dungeon.rooms[0]
add_data my_dungeon


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