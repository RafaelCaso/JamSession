extends Node2D

var metamask_connected = false


func _ready() -> void:
	Metamask.connect("request_accounts_finished", self, "_on_request_accounts_finished")


func _on_JamBtn_up() -> void:
	get_tree().change_scene("res://src/stages/Stage.tscn")


func _on_DisplayCaseBtn_up() -> void:
	get_tree().change_scene("res://src/DisplayCase.tscn")


func _on_StoreBtn_up() -> void:
	get_tree().change_scene("res://src/Store.tscn")


func _on_MainEntranceBtn_up() -> void:
	get_tree().change_scene("res://MainEntrance.tscn")


func _on_MetaMaskConnectBtn_up() -> void:
	Metamask.request_accounts()


func _on_request_accounts_finished(response):
	if response.error != null:
		# ToDo: give user feedback instead of print
		print("unable to connect account")
		return
	
	PlayerData.address = response.result[0]


