#### setup class
class Dungeon_thing  # parent object, not used directly
	attr_accessor :description, :long_description
	def initialize (description, long_description)
		@description, @long_description = description, long_description
	end
end

class Room < Dungeon_thing # has exits, contains items and monsters
	attr_accessor :exits, :items, :monsters
	def initialize (description, long_description)
		super description, long_description
		@exits = {}	
		@items, @monsters = [],[]
	end

	def long_description #override accessor to show exits, items, monsters
		return_string = @long_description + "\n"
		@exits.each {|direction,room| return_string <<"there is an exit #{direction.upcase} to #{room.description}\n" } #unless @exits.keys.count == 0
		@items.each {|item|  return_string << "you see item #{item.description}\n"}
		@monsters.each  {|monster|return_string << "you see monster #{monster.status} #{monster.description}\n"} 
		return return_string
	end
end

class Item < Dungeon_thing
end

class Monster < Dungeon_thing
	attr_accessor :status	
	def initialize (description, long_description)
		super description, long_description
		@status = "angry"	# monster starts off alive..
	end
end

def user_input (prompt)
	puts prompt
	until (input_array = gets.chomp.split(' ')).count > 0 do end # get some input
	return input_array.first.downcase, input_array.last.downcase
end

###### setup dungeon
kitchen = Room.new 'kitchen', 'a cluttered kitchen, light streams in through the window.'
dining = Room.new 'dining room',  'a dusty dining room. A fly buzzes around.'
inventory = Room.new 'inventory', 'You are carrying the following'
kitchen.exits['N'] = dining
dining.exits['S'] = kitchen

# setup items
toast = Item.new 'toast', 'A piece of buttered toast'
empty_gun = Item.new 'unloaded gun','an automatic pistol, it contains no bullets'
bullets = Item.new 'some bullets', 'some bullets. these look as if they will fit in the gun'
loaded_gun = Item.new 'loaded gun', 'a gun loaded with bullets'	# not initially in any room
kitchen.items.push toast
dining.items.push empty_gun
dining.items.push bullets
# setup monsters
hobgoblin = Monster.new 'Hobgoblin', 'A nasty looking goblin'
kitchen.monsters.push hobgoblin

##### test dungeon
current_room = kitchen	

loop do 
  puts ''
  puts "You are in #{current_room.long_description}"
  puts ''
  verb, noun = user_input "please enter instruction (verb, noun)"
    case verb
	when  'move','go'
	  	current_room = current_room.exits[noun.upcase[0]] # use first character of noun only
	  	puts "You go #{noun.upcase} to #{current_room.description}"
	when  'inventory','inv'
	  	puts inventory.long_description
	when  'get' 	
	  	item = inventory.items.push current_room.items.pop
	  	puts "you pick up #{item.last.description}" 
	when  'drop'
		item = current_room.items.push inventory.items.pop
	  	puts "you drop {item.last.description}"	
	when  'load'
		if inventory.items.include?(empty_gun) && inventory.items.include?(bullets)
			inventory.items.delete(empty_gun)
			inventory.items.delete(bullets)
			inventory.items.push loaded_gun
			puts "click! You loaded the bullets into the gun"
		else
			puts "You need empty gun and bullets to load"
		end
	when 'shoot'
		if inventory.items.include?(loaded_gun) && current_room.monsters.count > 0
			puts "BANG BANG"
			current_room.monsters.each do |monster|
				puts "You hit #{monster.description}"
				monster.status = "dead"
				monster.long_description = "A bloodstained body with bullet holes"
			end
		else
			puts "you can't shoot anything"
		end
	when 'exit','quit','q'
		puts 'thanks for playing, bye'
		break
	else
		puts "Sorry, didn't understand. Try 'go N', 'inv', 'get item' or 'quit'"
  	end	

end





