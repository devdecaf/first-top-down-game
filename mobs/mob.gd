class_name Mob
extends CharacterBody2D

## The top speed that the mob will follow the player
@export var max_speed := 200.0
## How quickly speed is added to the mob once it starts following
@export var acceleration := 600.0
## The amount of damage the mob can take before it dies
@export var health := 3:
	set = _set_health
## The amount of damage that the mob inflicts on the player
@export var damage := 15
## The amount of time to wait before inflicting damage (in seconds)
@export var time_between_damage := 3

var _player: Player = null

@onready var _detection_area: Area2D = %DetectionArea
@onready var _hit_box: Area2D = $HitBox
@onready var _damage_timer: Timer = %DamageTimer


func _ready() -> void:
	_damage_timer.wait_time = time_between_damage

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

	_hit_box.body_entered.connect(
		func(body: Node) -> void:
			if body is Player and _damage_timer.is_stopped():
				_player._health -= damage
				_damage_timer.start()
	)

	_hit_box.body_exited.connect(
		func(body: Node) -> void:
			if body is Player:
				_damage_timer.stop()
	)

	_damage_timer.timeout.connect(
		func() -> void:
			if _player != null:
				_player._health -= damage
				_damage_timer.start()
	)


func _physics_process(delta: float) -> void:
	if _player != null:
		var direction := global_position.direction_to(_player.global_position)
		var desired_velocity := direction * max_speed

		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		move_and_slide()


func _set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		_die()


func _die() -> void:
	if is_physics_processing():
		set_physics_process(false)
	if not is_queued_for_deletion():
		queue_free()
