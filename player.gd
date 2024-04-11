extends CharacterBody2D
class_name Player

signal hit
signal boost_changed(new_boost)
@export var speed = 400 #how fast the player moves
var screen_size #size of the game window
const max_boost=100
var boost=0
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	# Technically, moving diagonally is now faster than moving in any single direction.
	# While that was the behavior of some older games, it is a bit suspicious.
	# Any idea why is that the case? 
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	#if velocity is 1 usually , in both direction it would be 1.4 using pythagorian formula , so dividing by that
	#when going diagonally it will work
	if velocity.y != 0 and velocity.x != 0:
		velocity.y = velocity.y / 1.4
		velocity.x = velocity.x / 1.4
		
		
	# a bit of reordering to make this slightly easier on the eyes.
	# Also, you're currently recharding the booster before the game starts.
	# What can you do about it?
	if Input.is_action_pressed("boost_player"): #This is the boost function it
		boost= boost - 20 * delta              #the implementation might not be optimum but this is the 1st
		if boost > 0 :                       #easy solution that came to mind
			speed=800
		else :
			speed=400
	else: 
		if boost < max_boost:
			boost=boost+ 8 * delta
		speed=400
		
	# you basically want to update the boost every frame. 
	# (except for when its full, but we don't need to overoptimize rn.)
	emit_signal("boost_changed",boost)
	#im trying to update the progress bar
	
	#Yup, animations are a bitch.
	if velocity.length() > 0:
		velocity=velocity  * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	move_and_collide(velocity * delta)
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled=false


func _on_hitbox_body_entered(body):
	
	# What would happen if we removed this IF?
	# How to make it so that the first type of the enemy kills you once again?
	# WELL i played your game :)) and made another class. By removing the if, initially nothing would happen
	# but it might accidentally "kill" the player in case we introduce other elements , for a example a fill up boost
	# item spawned randomy
	if body is Enemy or body is Enemy2:
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled",true)
		


func _on_area_2d_body_entered(body):
	#print(position," is here")
	pass



