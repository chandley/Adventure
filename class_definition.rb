
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
		puts @long_description
		@exits.each {|direction,room| puts "there is an exit #{direction.upcase} to #{room.description}" } unless @exits.keys.count == 0
		@items.each {|item| puts "you see item #{item.description}"}
		@monsters.each {|monster| puts "you see monster #{monster.description} "}
	end
end

class Item < Dungeon_thing
end

class Monster < Dungeon_thing
end


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

current_room = kitchen	
puts current_room.long_description

current_room = current_room.exits['N']
puts current_room.long_description

puts inventory.long_description




