extends Node2D


onready var floodlight = $Light2D

var speed = 5
var direction = 'right'

func _process(delta):
	if rotation_degrees >= 10:
		direction = 'left'
	
	if rotation_degrees <= -10:
		direction = "right"
	
	if direction == "right":
		rotation_degrees += 1 * speed * delta
	elif direction == "left":
		rotation_degrees -= 1 * speed * delta
	
