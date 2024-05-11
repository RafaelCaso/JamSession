extends Node2D

#### For dev purposes only
#### replace with aesthetic solution for leaving stage
#### (can't obscure visual of stage)
func _on_TextureButton_up() -> void:
	get_tree().change_scene("res://MainEntrance.tscn")
