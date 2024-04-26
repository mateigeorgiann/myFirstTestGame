extends RigidBody2D
class_name Bullet

signal kill

var user

func _process(delta):
	pass
#I couldnt figure out how to make only the bullet killing the enemies not vice versa im gonna try using some signals
#or to see if i can connect with $ in the node scene .
#Also I will have to fix the warning idk what it means

#now bullet checks for enemies inside itself and kills both the enemy ( which are now part of a group ) and
#the bullet itself.
func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		queue_free()
		body.queue_free()
	#kills the bullet if it hits a wall
	elif body.is_in_group("walls"):
		queue_free()
		print("BULLET KILLED")
