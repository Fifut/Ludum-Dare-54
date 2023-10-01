extends GridContainer



func _ready():
	for i in 15:
		var lead_scene = preload("res://Menu/lead.tscn").instantiate()
		lead_scene.num = i+1
		add_child(lead_scene)
