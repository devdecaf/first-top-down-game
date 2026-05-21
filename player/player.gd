class_name Player
extends CharacterBody2D

const GODOT_BOTTOM = preload("uid://bw03btxpkxde4")
const GODOT_RIGHT = preload("uid://dscj1kv8s4bxa")
const GODOT_UP = preload("uid://b2q8n8kfhhbi7")
const GODOT_UP_RIGHT = preload("uid://deiak2vt25cwr")
const GODOT_BOTTOM_RIGHT = preload("uid://cm33qabjyo48g")
const UP_LEFT = Vector2.UP + Vector2.LEFT
const UP_RIGHT = Vector2.UP + Vector2.RIGHT
const DOWN_LEFT = Vector2.DOWN + Vector2.LEFT
const DOWN_RIGHT = Vector2.DOWN + Vector2.RIGHT

## The max speed that the player will move around the map
@export var max_speed := 500.0
## The max health of the player
@export var max_health := 100
## How quickly the player gets up to max speed
@export var acceleration := 2500.0
## How quickly the player stops moving
@export var deceleration := 3000.0

@onready var _skin: Sprite2D = %Skin
@onready var _collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var _weapon_pivot: WeaponPivot = %WeaponPivot
@onready var _weapon: Weapon = %Weapon
@onready var _health_bar: TextureProgressBar = %HealthBar
@onready var _health := max_health:
	set = _set_health


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction.length() > 0.0:
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()

	var direction_discrete := direction.sign()
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			_skin.texture = GODOT_RIGHT
		Vector2.UP:
			_skin.texture = GODOT_UP
		Vector2.DOWN:
			_skin.texture = GODOT_BOTTOM
		UP_RIGHT, UP_LEFT:
			_skin.texture = GODOT_UP_RIGHT
		DOWN_RIGHT, DOWN_LEFT:
			_skin.texture = GODOT_BOTTOM_RIGHT

	if direction.length() > 0.0:
		_skin.flip_h = direction.x < 0.0


func _set_health(new_health: int) -> void:
	_health = clampi(new_health, 0, max_health)
	_health_bar.value = _health * 100.0 / max_health
	if _health == 0:
		_die()


func _die() -> void:
	set_physics_process(false)
	_weapon_pivot.set_process(false)
	_weapon_pivot.set_process_unhandled_input(false)
	_weapon.set_process_input(false)
	_collision_shape_2d.set_deferred("disabled", true)
