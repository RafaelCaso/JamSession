extends Node2D

var metadata_scene = preload("res://src/util/Metadata.tscn")
var nft_metadata

var token_ids
var token_id_size
var current_token_index = 0
var row_count = 1
var column_count = 2
var sprite_size = Vector2(200, 200)
var spacing = Vector2(100, 100)

var http

# on ready, get all URIs for NFTs belonging to connected account
func _ready() -> void:
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("http://127.0.0.1:3000/ownedTokens/" + str(PlayerData.address))	

# complete request for URIs and call func to begin loading each NFT image
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	token_ids = json.result["tokenIds"]
	get_metadata()

# 
func get_metadata():
	nft_metadata = null
	http = HTTPRequest.new()
	add_child(http)
	var size = token_ids.size()
	if current_token_index < size:
		http.connect("request_completed" , self, "get_image_data")
		http.request("http://127.0.0.1:3000/getURI/" +str(token_ids[current_token_index]))
		current_token_index += 1
	else:
		var children = get_children()
		for child in children:
			if child is HTTPRequest:
				child.queue_free()
		

func get_image_data(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var img_cid = json.result["metaData"]["image"]
	
	nft_metadata = metadata_scene.instance()
	nft_metadata.nft_name = json.result["metaData"]["name"]
	nft_metadata.img_cid = json.result["metaData"]["image"]
	nft_metadata.audio_cid = json.result["metaData"]["audio"] 
	
	http.disconnect("request_completed", self, "get_image_data")
	http.queue_free()
	
	var new_http = HTTPRequest.new()
	add_child(new_http)
	
	new_http.connect("request_completed", self, "load_image")
	new_http.request("http://127.0.0.1:8080/ipfs/" + str(img_cid))

func load_image(result, response_code, headers, body):
	var image_texture = ImageTexture.new()
	var image_data = Image.new()
	var err = image_data.load_png_from_buffer(body)
	image_texture.create_from_image(image_data)
	var sprite = Sprite.new()
	sprite.texture = image_texture
	sprite.add_to_group("Instrument")
	add_child(sprite)
	sprite.add_child(nft_metadata)
	sprite.position = calculate_sprite_position()
	get_metadata()


func calculate_sprite_position() -> Vector2:
	var position = Vector2(column_count * (sprite_size.x + spacing.x), row_count * (sprite_size.y + spacing.y))
	column_count += 1
	if column_count >= 5:
		column_count = 2
		row_count += 1
	return position


# this spaghetti is better than the spaghetti I was making
# index 0 = search by genre
# index 1 = search by instrument type
func rearrange_display(item_name, index):
	row_count = 1
	column_count = 2
	var children = get_children()
	for child in children:
		if child.is_in_group("Instrument"):
			if item_name == "all":
				child.visible = true
				child.global_position = calculate_sprite_position()
			else:
				var metadata = child.get_child(0)
				var metadata_name = str(metadata.nft_name)
				var sub_string = metadata_name.split(" ")[index]
				if sub_string == item_name:
					child.visible = true
					child.global_position = calculate_sprite_position()
				else:
					child.visible = false 

# Buttons for rearranging display
func _on_AllBtn_up() -> void:
	rearrange_display("all", 0)


func _on_GuitarBtn_button_up() -> void:
	rearrange_display("guitar", 1)


func _on_BassBtn_button_up() -> void:
	rearrange_display("bass", 1)


func _on_DrumsBtn_button_up() -> void:
	rearrange_display("drums", 1)


func _on_MetalBtn_button_up() -> void:
	rearrange_display("metal", 0)


func _on_JazzBtn_button_up() -> void:
	rearrange_display("jazz", 0)


func _on_PopBtn_button_up() -> void:
	rearrange_display("pop", 0)
