@tool
class_name Weapon
extends Node2D

## The bullet that is spawned when shooting the weapon
@export var bullet_scene: PackedScene = null:
	set = _set_bullet_scene
## The maximum range that the bullet will travel
@export var max_range := 2000.0
## The maximum speed at which the bullet will travel
@export var max_bullet_speed := 1150.0
## The maximum amount of random rotation to add to the bullet
@export_range(0.0, PI / 4, 0.01) var max_random_angle = 0.0


func _input(event: InputEvent) -> void:
	if (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	):
		shoot()


func _get_configuration_warnings() -> PackedStringArray:
	if bullet_scene == null:
		return ["Weapon requires a bullet scene to spawn."]
	return []


func shoot() -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.max_range = max_range
	bullet.speed = max_bullet_speed
	bullet.rotation = randf_range(-max_random_angle, max_random_angle)
	add_child(bullet)


func _set_bullet_scene(new_bullet_scene: PackedScene) -> void:
	bullet_scene = new_bullet_scene
	update_configuration_warnings()
