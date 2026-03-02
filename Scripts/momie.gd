extends CharacterBody2D

@onready var hittimer = $HitTimer
@onready var sprite = $Sprite2D

var health = 3


func take_damage(amount:int):
	health -= amount
	sprite.modulate = Color.RED
	sprite.scale = Vector2(0.7,1.3)
	hittimer.start()
	
	if health <= 0:
		queue_free()
	
func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# we check if target is not null to avoid crashes
	if target != null:
		# Direction toward something is a vector the math formula always is
		# Target_vector2(taregt.global_position) - My_vector2(global_postion)
		var direction = (target.global_position - global_position).normalized()
		#
		var target_velcotiy = direction * speed
		velocity = velocity.move_toward(target_velcotiy,speed*delta)
		
		# calling this function is critical to move 
		move_and_slide()
	
	

func _on_hit_timer_timeout() -> void:
	sprite.scale = Vector2(1,1)
	sprite.modulate = Color.WHITE
