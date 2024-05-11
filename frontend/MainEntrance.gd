extends Node2D

var action_not_pressed = true

func _on_DoorBtn_button_up() -> void:
		get_tree().change_scene("res://src/Store.tscn")
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$JamSessionSign.visible = !action_not_pressed
		$JamSessionSign.set_process(!action_not_pressed)
		$Sprite5.visible = action_not_pressed
		action_not_pressed = !action_not_pressed 
