extends Node2D


@onready var MenuCanvasLayer = %MenuCanvasLayer
@onready var LoopAudioStreamPlayer = %LoopAudioStreamPlayer


func _on_menu_container_on_start():
	MenuCanvasLayer.queue_free()
	
	var game = preload("res://Game/game.tscn").instantiate()
	add_child(game)


func _on_intro_audio_stream_player_finished():
	LoopAudioStreamPlayer.play()
