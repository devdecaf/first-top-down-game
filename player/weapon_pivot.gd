class_name WeaponPivot
extends Node2D


func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(get_global_mouse_position())
	var angle := direction.angle()
	global_rotation = rotate_toward(angle, global_rotation, delta)
