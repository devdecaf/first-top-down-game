class_name Weapon
extends Node2D


func _input(event: InputEvent) -> void:
	if (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	):
		shoot()


func shoot() -> void:
	print("spawned bullet")
