extends CharacterBody2D
# If you create one "base" class called Enemy, that inherits from CharacteBody2D
# you can have some common behaviors there (like dying to a bullet)
class_name Enemy

var _player
# Called when the node enters the scene tree for the first time.
func _ready():
	#These are usually easier to set in the GUI on the right side.
	#enemy2 -> Inspector menu on the right side -> Collision -> layer & mask.

	collision_layer = 1
	collision_mask = ~1

func set_player(player):
	_player = player
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _player != null:
		#Actually this is all you need - you had most of the stuff already in place, however you
		#panicked and started doing some stuff that you got tangled in.
		#That being said, this makes the enemies basically undodgeable,
		#as it makes them into perfect homing missiles. 
		#Try to "nerf" this to make them only be attracted to the player a bit.
		#Also, this is not rotating the sprite, only moving the enemy in the correct direction.
		
		var player_position = _player.position
			#trying to get the coordonates of the player
		var direction = (player_position - position).normalized()
		var rotation_angle = atan2(direction.y, direction.x)
		rotation_degrees = rotation_angle * deg_to_rad(1.0)
		#linear_velocity = direction.normalized() * 600 
		#spawn mob
		

		#linear_velocity= direction.normalized() * 0
		
		#direction = (player_position - position).normalized()
		#here i realise i need to work on my trigonometry cause i didnt know why arc tan is used
		#i inspired the code from many different forums, compiled them toghether to get a result
		#rotation_angle = atan2(direction.y,direction.x)
		#rotation_degrees = deg_to_rad(0.0)
		#rotation_degrees = rotation_angle * deg_to_rad(1.0)

		move_and_collide(direction * 500 * delta)
