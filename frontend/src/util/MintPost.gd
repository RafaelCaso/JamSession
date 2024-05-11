extends HTTPRequest

signal send_data(data)

# don't need this ready func or the logic in _on_request_completed
func _ready() -> void:
	self.connect("request_completed", self, "_on_request_completed")


func _on_request_completed(result, response_code, headers, body):
#	emit_signal("send_data", body.get_string_from_utf8())
	
	var body_string = body.get_string_from_utf8()
	emit_signal("send_data", body_string["status"])
	

func _make_post_request(nft_name, img_cid, audio_cid):
	
	var query_data = {
		"address" : PlayerData.address,
		"nftName" : nft_name,
		"imageCID" : img_cid,
		"audioCID" : audio_cid
	}

	var query = JSON.print(query_data)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	self.request("http://127.0.0.1:3000/mintNFT", headers, false, HTTPClient.METHOD_POST, query)


