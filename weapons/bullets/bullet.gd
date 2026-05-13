class_name Bullet
extends Area2D

## The speed at which the bullet moves
@export var speed := 1500.0
## The maximum distance the bullet will travel
@export var max_range := 1000.0

var _starting_position: Vector2


func _ready() -> void:
	_starting_position = position


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

	if _starting_position.distance_to(position) >= max_range:
		destroy()


func destroy() -> void:
	queue_free()
