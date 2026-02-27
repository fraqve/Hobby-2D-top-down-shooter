extends CharacterBody2D
var direction = 0
var speed = 175
var acceleration = 1000
var friction = 1200
var roll_power = 475

@onready var rolltimer = $Timers/RollTimer
@onready var rollreload = $Timers/RollReload
@onready var gun = $Gun
@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
@onready var sprite = $Sprite2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# get_vector returns a vector 2 when pressing keys
	# argument 0 is left 1 is right 2 is up 3 is down any chnage
	# Would make the player goes in the revrse diretion
	
	var direction =  Input.get_vector("move_left","move_right","move_up","move_down")
	# this makes momvent only worksi outside the dash
	if rolltimer.is_stopped():
		if direction != Vector2.ZERO:
			# move toward here needs two argumnets
			# destination and acceleration
			#this destionation is the accleratio  of the character
			velocity = velocity.move_toward(direction * speed, acceleration * delta)
			
		else:
			# Hanldes deaceleration when realsin the key
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else: # friction always works dash or not
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	# look at roattes the node to look toward something
	# get_global_mouse_position is the mouse postion now it
	# it looks toward the mouse
	gun.look_at(get_global_mouse_position())
	
	# This part will handle the bullet logic
	if Input.is_action_just_pressed("shoot"):
		# We creat a scean of the bullet
		var bullet = bullet_scene.instantiate()
		# Set it roation and postition so whe we mve forwad we use the x of the bullet not global x
		bullet.global_position = $Gun/muzzle.global_position
		bullet.rotation = gun.rotation 
		# We add that scean we created to the main game scean so it shows up
		get_tree().root.add_child(bullet)

	if Input.is_action_just_pressed("roll") and rollreload.is_stopped():
		var roll_direction = (get_global_mouse_position() - global_position).normalized()
		# first we cancel the momvment veloctiy
		velocity = Vector2.ZERO
		
		velocity += roll_direction * roll_power
		# stretching sprtie
		sprite.scale = Vector2(1.3,0.7)
		rolltimer.start()
		rollreload.start()
	
	# The '5.0' is how fast it snaps back. Adjust to taste!
	sprite.scale = sprite.scale.move_toward(Vector2(1,1), 2.5 * delta)

	move_and_slide()
	
