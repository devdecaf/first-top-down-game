class_name Bullet
extends Area2D

## The speed at which the bullet moves
@export var speed := 1000.0


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	global_position += direction * speed * delta
