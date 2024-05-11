extends AnimatedSprite

export var img_cid = ""

export var name_display = ""
export var update_display = true
export var product_data1 = ""
export var product_data2 = ""
export var product_data3 = ""

export var guitar = true
export var instrument_type = ""

var state = true
var focus = false

var start_pos

func _ready() -> void:
	start_pos = $InstrumentSprite.global_position
	$DisplayBG.global_position = Vector2(960, 540)
	$DisplayBG/ProductName.text = name_display
	$DisplayBG/ProductData1.text = product_data1
	$DisplayBG/ProductData2.text = product_data2
	$DisplayBG/ProductData3.text = product_data3

func _play_animation():
	if guitar:
		if state == true:
			play("open")
		else:
			play("close")
		
		state = !state


func _on_TextureButton_button_up() -> void:
	_play_animation()
	$InstrumentSprite.z_index = 2
	$Tween.interpolate_property($InstrumentSprite, "global_position", $InstrumentSprite.global_position, Vector2(960, 540), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if update_display:
		$Tween.interpolate_property($InstrumentSprite, "scale", $InstrumentSprite.scale, $InstrumentSprite.scale * 2, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($InstrumentSprite, "rotation_degrees", $InstrumentSprite.rotation_degrees, $InstrumentSprite.rotation_degrees + 90, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
	$Tween.start()
	$Tween.connect("tween_all_completed", self, "display_screen")
	


func tween_finished():
	$InstrumentSprite.z_index = 0
	_play_animation()
	$Tween.disconnect("tween_all_completed", self, "tween_finished")

func display_screen():
	$DisplayBG.visible = true
	$Tween.disconnect("tween_all_completed", self, "display_screen")


func _on_closeBtn_up() -> void:
	$DisplayBG.visible = false
	$Tween.interpolate_property($InstrumentSprite, "global_position", $InstrumentSprite.global_position, start_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if update_display:
		$Tween.interpolate_property($InstrumentSprite, "scale", $InstrumentSprite.scale, $InstrumentSprite.scale * 0.5, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($InstrumentSprite, "rotation_degrees", $InstrumentSprite.rotation_degrees, $InstrumentSprite.rotation_degrees - 90, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
	$Tween.start()
	$Tween.connect("tween_all_completed", self, "tween_finished")



func _on_PurchaseNftBtn_up() -> void:
	PlayerData.selected_nft_img = img_cid
	PlayerData.sample_instrument = instrument_type
	get_tree().change_scene("res://src/GenreSelector.tscn")

