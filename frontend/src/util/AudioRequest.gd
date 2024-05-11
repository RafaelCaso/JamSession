extends HTTPRequest
#Audio Request for Stages

# get cid from parent GetNFTRequest
# instantiate one GetNFTRequest for each performing instrument
onready var cid = get_parent().audio_cid

# bool for muteBtn to determine mute or play
var playing = true
var floodlight

func _ready():
	floodlight = get_parent().find_node("FloodLight")
	
	# Connect and trigger HTTP request
	self.connect("request_completed", self, "_on_request_completed")
	self.request("http://127.0.0.1:8080/ipfs/" + String(cid))
	

# handle response from HTTP request
func _on_request_completed(result, response_code, headers, body):
	
	# create temp file and store audio received in body
	var temp_file_path = "res://temp_audio.ogg"
	var file = File.new()
	file.open(temp_file_path, File.WRITE)
	file.store_buffer(body)
	file.close()
	
	# instantiate AudioStreamPlayer and AudioLoader
	var audio_player = AudioStreamPlayer.new()
	var audio_loader = AudioLoader.new()
	
	# use audio_loader to create data from OGG file and add to audio player stream
	audio_player.stream = audio_loader.loadfile(temp_file_path)
	add_child(audio_player)
	audio_player.play()
	
	# access mute button node and connect mute button toggled function
	# pass audio_player in button_up to keep mute logic specific to each instrument
	var muteBtn = get_parent().find_node("MuteBtn")
	muteBtn.connect("button_up", self, "_on_muteBtn_toggled", [audio_player])

# mute sound by lowering DG to inaudible level
# connect floodlight with mute property
func _on_muteBtn_toggled(audio):
	playing = !playing
	
	if playing:
		audio.set_volume_db(0)
		floodlight.visible = true
	if !playing:
		audio.set_volume_db(-100)
		floodlight.visible = false
