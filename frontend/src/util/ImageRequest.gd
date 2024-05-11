extends HTTPRequest

onready var cid = get_parent().img_cid
onready var coords = get_parent().coords


# This script is actually for the stage presentation (with floodlight and mute button
# Script needs to be renamed
func _ready():
	self.connect("request_completed", self, "_on_request_completed")
	self.request("http://127.0.0.1:8080/ipfs/" + String(cid))
func _on_request_completed(result, response_code, headers, body):

	var image_texture = ImageTexture.new()
	var image_data = Image.new()
	var err = image_data.load_png_from_buffer(body)
	image_texture.create_from_image(image_data)
	var sprite = Sprite.new()
	sprite.texture = image_texture
	sprite.global_position = coords
	add_child(sprite)
	
	var icon_coords = coords
	var floodlight_coords = coords
	
	icon_coords.y += 120
	icon_coords.x -= 10
	$MuteBtn.set_global_position(icon_coords)
	
	floodlight_coords.y +=  623
	floodlight_coords.x -= 60
	$FloodLight.rotation_degrees = rand_range(-10, 10)
	$FloodLight.global_position = floodlight_coords
