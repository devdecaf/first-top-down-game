class_name Bullet
extends Area2D

## The speed at which the bullet moves
@export var speed := 1500.0
## The maximum distance the bullet will travel
@export var max_range := 1000.0

var starting_position: Vector2


func _ready() -> void:
	starting_position = global_position


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	global_position += direction * speed * delta

	if starting_position.distance_to(global_position) >= max_range:
		_destroy()


func _destroy() -> void:
	queue_free()
