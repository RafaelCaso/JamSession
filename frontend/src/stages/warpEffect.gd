extends ColorRect


func _ready():
	material.duplicate()
	adjustRect()

func adjustRect():
	material.set_shader_param("rel_rect_size", get_canvas_transform().get_scale()*rect_size)
		
func _process(_delta):
	adjustRect()
