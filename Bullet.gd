extends RigidBody2D
<<<<<<< HEAD
class_name Bullet
=======

>>>>>>> 4713ecfa4c33cb0f702eb00cb5c85720bad37ef9
signal kill
var user

func _process(delta):
	pass
#I couldnt figure out how to make only the bullet killing the enemies not vice versa im gonna try using some signals
#or to see if i can connect with $ in the node scene .
#Also I will have to fix the warning idk what it means


func _on_area_2d_body_entered(body):
	if ( body == Enemy or body == Enemy2 ) and body.user != self:
		#i dont understand why it doesnt enter the the if , i tried to do the coin thing and theoretically 
		#it should have worked , im gonna try next week maybe it will work.
		queue_free()
