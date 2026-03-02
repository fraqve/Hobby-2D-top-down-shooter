extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.bullet_shot.connect(_on_bullet_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_bullet_shot(bullet,pos,rot):
	add_child(bullet)
	bullet.global_position = pos
	bullet.rotation = rot
