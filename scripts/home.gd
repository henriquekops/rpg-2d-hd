extends Node2D

func _ready():
	$HomeMusic.play()

func _on_play_pressed():
	$HomeMusic.stop()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
