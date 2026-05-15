class_name Mob
extends CharacterBody2D

## The top speed that the mob will follow the player
@export var max_speed := 200.0
## How quickly speed is added to the mob once it starts following
@export var acceleration := 600.0

var _player: Player = null

@onready var _detection_area: Area2D = %DetectionArea


func _ready() -> void:
	_detection_area.body_entered.connect(
		func(body: Node) -> void:
			if body is Player:
				_player = body
	)

	_detection_area.body_exited.connect(
		func(body: Node) -> void:
			if body is Player:
				_player = null
	)


func _physics_process(delta: float) -> void:
	if _player != null:
		var direction := global_position.direction_to(_player.global_position)
		var desired_velocity := direction * max_speed

		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		move_and_slide()
