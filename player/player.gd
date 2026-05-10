extends CharacterBody2D

## The max speed that the player will move around the map
@export var max_speed := 500.0

## How quickly the player gets up to max speed
@export var acceleration := 2500.0

## How quickly the player stops moving
@export var deceleration := 3000.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction.length() > 0.0:
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()
