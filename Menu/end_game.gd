extends Control


@onready var ScoreLabel : Label = %ScoreLabel
@onready var NameLineEdit : LineEdit = %NameLineEdit
@onready var WebSocket = %WebSocket
@onready var LeaderGridContainer = %LeaderGridContainer


signal restart


func _ready():
	WebSocket.connect_to_server(true)


func _exit_tree():
	WebSocket.connect_to_server(false)



var orbiting_satellite: int = 0:
	set(value) :
		ScoreLabel.text = "Orbiting satellite : " + str(value)




func _on_submit_button_pressed():
	
	var _name = NameLineEdit.text
	if _name == "" or null:
		return
	else:
		WebSocket.send_to_server(_name, orbiting_satellite)
	
	EVENT.restart.emit()


func _on_visibility_changed():
	if visible:
		WebSocket.send_to_server("Leaderboard", 0)


func _on_web_socket_client_message_received(message):
	var leaderboard = JSON.parse_string(message) # Dictionnary
	for num in leaderboard:
		var lead = leaderboard[num]
		var lead_name = lead["Name"]
		var lead_point = lead["Points"]
		
		var node = LeaderGridContainer.get_node_or_null("Lead" + num)
		if node:
			node.lead_name = lead_name
			node.pts = lead_point
