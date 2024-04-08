extends RigidBody2D

signal kill

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 1



func _process(delta):
	pass
#I will have to add a way of killing X instance of hit enemy , didnt look too much into it
#Also I will have to fix the warning idk what it means
#also also the main code is in node scene
