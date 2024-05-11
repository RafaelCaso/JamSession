extends Node2D


onready var metal = $MusicStand/MetalSheetMusic
onready var jazz = $MusicStand/JazzSheetMusic
onready var pop = $MusicStand/PopSheetMusic

var page = 0
var playing = true

var dict = preload("res://CidDict.gd")

func _ready() -> void:
	# initialize sample_genre var with default genre (currently metal)
	# var changed in func _on_TurnPageBtn_up
	PlayerData.sample_genre = "metal"
	
	$AudioRequest.connect("request_completed", self, "_on_audio_request_completed")
	
	# Sample music for selected instrument loaded automatically.
	# currently, Metal audio hardcoded in
	# Genre needs to change depending on which page is selected in the song book
	match PlayerData.sample_instrument:
		"guitar":
			$AudioRequest.request("http://127.0.0.1:8080/ipfs/QmSFLEuRSyMAi8K1CHJwzvkE4M8k2WrnpUXSxfRkUn5fSA")
		"bass":
			$AudioRequest.request("http://127.0.0.1:8080/ipfs/QmdB9Ks6Fww9tcLntZ9pv2YqM8QPdZBdZfX22tpHJhkmtG")
		"drums":
			$AudioRequest.request("http://127.0.0.1:8080/ipfs/QmRCNWVpt6whTYEQwKomGCciSaPFRjySNBnpcHJ74fxPXD")
		"piano":
			$AudioRequest.request("http://127.0.0.1:8080/ipfs/QmSVcgzeFNgohDYQ5fgjMb5u86TDZiDLSJYFNj87JNQ9WB")
	
	
	$MintNFTRequest/MintPost.connect("send_data",self, "prompt_user")
	$ImgRequest.connect("request_completed", self, "_on_img_request_completed")
	$ImgRequest.request("http://127.0.0.1:8080/ipfs/" + PlayerData.selected_nft_img)
	Metamask.connect("request_accounts_finished", self, "_on_request_accounts_finished")


func _on_img_request_completed(result, response_code, headers, body):
	var image_texture = ImageTexture.new()
	var image_data = Image.new()
	var err = image_data.load_png_from_buffer(body)
	image_texture.create_from_image(image_data)
	$Instrument.texture = image_texture

func prompt_user(prompt):
	$UserPrompt.visible = true
	$UserPrompt/Label.text = prompt
	$UserPrompt/CloseBtn.connect("button_up", self, "_close_prompt")

func _close_prompt():
	$UserPrompt.visible = false
	$UserPrompt/CloseBtn.disconnect("button_up", self, "_close_prompt")
	$YesBtn.visible = false
	$NoBtn.visible = false

# start with metal CID
# ToDo: add CIDs for different genres in match statement
# When user pushes LearnBtn, set player_data.selected_audio = selected_genre_cid
var selected_genre_cid = "QmSFLEuRSyMAi8K1CHJwzvkE4M8k2WrnpUXSxfRkUn5fSA" 

func _on_TurnPageBtn_up() -> void:
	match page:
		0:
			PlayerData.sample_genre = "jazz"
			metal.visible = false
			jazz.visible = true
			page = 1
			_make_audio_request(PlayerData.sample_genre, PlayerData.sample_instrument)
		1:
			PlayerData.sample_genre = "pop"
			jazz.visible = false
			pop.visible = true
			page = 2
			_make_audio_request(PlayerData.sample_genre, PlayerData.sample_instrument)
		2:
			PlayerData.sample_genre = "metal"
			pop.visible = false
			metal.visible = true
			page = 0
			_make_audio_request(PlayerData.sample_genre, PlayerData.sample_instrument)

# I hate how it says Btn and button.......
func _on_LearnBtn_button_up() -> void:
	PlayerData.selected_nft_name = str(PlayerData.sample_genre) + " " + str(PlayerData.sample_instrument)
	PlayerData.selected_nft_audio = selected_genre_cid
	if PlayerData.address.length() < 25:
		prompt_user("Please connect your wallet to proceed")
		return
	$MintNFTRequest/MintPost._make_post_request(
		PlayerData.selected_nft_name,
		PlayerData.selected_nft_img, 
		PlayerData.selected_nft_audio
		)
	prompt_user("Congrats ! Now get out there and jam!")


func _on_ExitBtn_button_up() -> void:
	PlayerData.selected_nft_img = ""
	get_tree().change_scene("res://src/Store.tscn")


func _on_MetaMaskConnectBtn_up() -> void:
	var connected = Metamask.is_network_connected()

	if connected:
		Metamask.request_accounts()

func _on_request_accounts_finished(response):
	if response.error != null:
		prompt_user("Request failed. Reason: " + response.error.message)
		return 
	PlayerData.address = response.result[0]
	prompt_user(PlayerData.address)



func _on_audio_request_completed(result, response_code, headers, body):
	var temp_file_path = "res://temp_audio.ogg"
	var file = File.new()
	file.open(temp_file_path, File.WRITE)
	file.store_buffer(body)
	file.close()
	
	
	var audio_loader = AudioLoader.new()
	$AudioStreamPlayer.stream = audio_loader.loadfile(temp_file_path)
	$AudioStreamPlayer.play()


	$MuteBtn.connect("button_up", self, "_on_muteBtn_toggled", [$AudioStreamPlayer])

func _on_muteBtn_toggled(audio):
	playing = !playing
	
	if playing:
		audio.set_volume_db(0)
	if !playing:
		audio.set_volume_db(-100)


func _make_audio_request(genre, instrument):
	var data = dict.DATA
	$AudioRequest.request("http://127.0.0.1:8080/ipfs/" + data[genre][instrument]["audio"])


func _on_PurchaseNFTBtn_up() -> void:
	PlayerData.selected_nft_name = str(PlayerData.sample_genre) + " " + str(PlayerData.sample_instrument)
	PlayerData.selected_nft_audio = selected_genre_cid
	if PlayerData.address.length() < 25:
		prompt_user("Please connect your wallet to proceed")
		return
	else:
		prompt_user("Are you sure you want the " + str(PlayerData.sample_genre) + " " + str(PlayerData.sample_instrument) + "?")
		$YesBtn.visible = true
		$NoBtn.visible = true


func _on_NoBtn_button_up() -> void:
	_close_prompt()


func _on_YesBtn_button_up() -> void:
	$YesBtn.visible = false
	$NoBtn.visible = false
	$MintNFTRequest/MintPost._make_post_request(
		PlayerData.selected_nft_name,
		PlayerData.selected_nft_img, 
		PlayerData.selected_nft_audio
		)
	prompt_user("Congrats ! Now get out there and jam!")
