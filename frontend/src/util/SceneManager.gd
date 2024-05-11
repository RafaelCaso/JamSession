extends Node

var current_scene = null


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.queue_free()
	
	var s = ResourceLoader.load(path)
	
	if s == null:
		printerr("Failed to load scene at path: " + path + " (GameManager.gd : line 15)")
		return
	current_scene = s.instance()
	
	get_tree().root.add_child(current_scene)
	
	get_tree().current_scene = current_scene
