extends Node

var dict = preload("res://CidDict.gd")

export var img_cid = ""
export var audio_cid = ""
export var coords = Vector2.ZERO

export var instrument = ""
export var genre = ""

func _ready():
	var data = dict.DATA

#	print(data[genre][instrument]["image"])
#	$ImageRequest.cid = String(data[genre][instrument]["image"])
#	$AudioRequest.cid = String(data[genre][instrument]["audio"])
	
#	$ImageRequest.cid = img_cid
#	$AudioRequest.cid = audio_cid
