extends Node2D


onready var world_env = $WorldEnvironment
onready var sprite = $Sprite

var glow = "more"
var speed = 0.5

func _process(delta: float) -> void:
	var env = world_env.get_environment()
	if env.glow_strength >= 1.2:
		glow = "less"
	if env.glow_strength <= 0.79:
		glow = "more"

	
	if glow == "less":
		env.glow_strength -= delta * speed
	if glow == "more":
		env.glow_strength += delta * speed
