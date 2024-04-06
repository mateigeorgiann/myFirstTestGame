extends Area2D

signal hit
@export var speed = 400 #how fast the player moves
var screen_size #size of the game window
const max_boost=100
var boost=0
signal boost_changed(new_boost)
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	collision_layer = 1
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("boost_player"): #This is the boost function it
		boost= boost - 20 * delta              #the implementation might not be optimum but this is the 1st
		if boost > 0 :                       #easy solution that came to mind
			speed=800
		else :
			speed=400
	if not Input.is_action_pressed("boost_player") && boost<max_boost:
		boost=boost+ 8 * delta
		speed=400
	emit_signal("boost_changed",boost)
	#im trying to update the progress bar
	
		
	if velocity.length() > 0:
		velocity=velocity.normalized() * speed
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
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
	


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled=false
