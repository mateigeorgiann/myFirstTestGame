extends RigidBody2D

class_name Enemy2
#I tried using Extend Enemy , so it owuld be part of class Enemy , or i tried attachign a script had to ctrl z 
#after I realised that i overwritten the code etc so i gave up that approach. Ill have to see in more detail

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
#Kill enemy when bullet his it
func _on_area_2d_body_entered(body):
	if body is Bullet and body.user != self:
		queue_free()
