class_name WeaponPivot
extends Node2D

enum InputDevice {
	MOUSE,
	GAMEPAD,
}

var _input_device := InputDevice.MOUSE


func _process(delta: float) -> void:
	var direction := (
		global_position.direction_to(get_global_mouse_position())
		if _input_device == InputDevice.MOUSE
		else Input.get_vector("look_left", "look_right", "look_up", "look_down")
	)

	if direction.length() > 0.0:
		var angle := direction.angle()
		global_rotation = rotate_toward(angle, global_rotation, delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		_input_device = InputDevice.GAMEPAD
	elif event is InputEventMouseMotion:
		_input_device = InputDevice.MOUSE
