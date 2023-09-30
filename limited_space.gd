extends Node2D


@onready var MenuCanvasLayer = %MenuCanvasLayer
@onready var LoopAudioStreamPlayer = %LoopAudioStreamPlayer

@onready var game_scene = preload("res://Game/game.tscn")

func _on_menu_container_on_start():
	MenuCanvasLayer.queue_free()
	
	var game = game_scene.instantiate()
	game.name = "Game"
	add_child(game)


func _on_intro_audio_stream_player_finished():
	LoopAudioStreamPlayer.play()


func _input(event):
	if event.is_action_released("Reset"):
		var game = get_node_or_null("Game")
		if game:
			remove_child(game)
			game.queue_free()
			
			var new_game = game_scene.instantiate()
			add_child(new_game)
