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
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

func _on_hit_timer_timeout() -> void:
	sprite.scale = Vector2(1,1)
	sprite.modulate = Color.WHITE
