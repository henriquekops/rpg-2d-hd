extends Node2D


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "do_splash":
		get_tree().change_scene_to_file("res://scenes/home.tscn")
