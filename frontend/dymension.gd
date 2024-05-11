extends TextureButton

func _ready():
	connect("button_up", self, "_on_button_pressed")

func _on_button_pressed():
	OS.shell_open("https://dymension.xyz/")
