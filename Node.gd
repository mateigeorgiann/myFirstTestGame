extends Node


@export var mob_scene: PackedScene
@export var enemy_2_scene:PackedScene
@export var bullet_scene:PackedScene

var score
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("player")
	$Player.boost_changed.connect(_on_boost_changed)

func _on_boost_changed(new_boost: int):
	$HUD/ProgressBar.value= new_boost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("click"):
		_on_mouse_click()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackgroundMusic.stop()
	$DeathSound.play()
	
func new_game():
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get ready")
	get_tree().call_group("mobs", "queue_free")
	$BackgroundMusic.play()

func _on_score_timer_timeout():
	score +=1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	
	#i know its not the perfect randomiser, i would use smth based on seed
	#maybe rewrite some algorithm but for such a small game i dont think its needed
	var randomValue = randi_range(0,100)
	print(randomValue," ", score)
	
	# Currently you start with the 2nd type of enemies ^^ :-)
	# However this is a good idea.
	if randomValue>score :
		#will spawn the new type which will go to 100 after score 100
		#this is the 1st method that came to mind that i could code with my current knowledge
		var mob = mob_scene.instantiate()
		# Choose a random location on Path2D.
		var mob_spawn_location = $MobPath/MobSpawnLocation
		mob_spawn_location.progress_ratio = randf()
		# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2
		# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position
		# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction
		# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)
		# Spawn the mob by adding it to the Main scene.
		add_child(mob)
	else :
		#create instance of enemy2
		var mob2 = enemy_2_scene.instantiate()
		#chooses a random place to spawn enemy
		var mob2_spawn_location = $MobPath/MobSpawnLocation
		mob2_spawn_location.progress_ratio = randf()
		#chooses position
		mob2.position = mob2_spawn_location.position
		mob2.set_player($Player)
		add_child(mob2)
		# HELP Here i have to see why after its instatieted i can only change speed and not rotation
		#fix THIS 1

#Fix this 2		
#bassically when the mouse is clicked the ideea is to create a new bullet , that bullet
#will spawn inside the player , eventually i will move it towards the direction by X ammount of pixels
#so it does get spawn from under the player . After it is instantieted i give it player position
#then, will rotate it towards the the mouse clock trough get_mouse_position() . Then I rotatae it like
#I did earlier with mob 2. After that its supposed to be given speed, but I didnt have time to fix all
#the crashes.
func _on_mouse_click():
	var bullet = bullet_scene.instantiate()
	bullet.position = $Player.position
	var mousePosition = get_viewport().get_mouse_position()
	var direction = (mousePosition - bullet.position).normalized()
	var rotation_angle = atan2(direction.y,direction.x)
	bullet.rotation_degrees = rotation_angle * deg_to_rad(1.0)
	bullet.linear_velocity = direction.normalized() * 500
	add_child(bullet)
	
