extends Label

signal finished
@export var full_text: String
var character_pos: int = 0

func _on_timer_timeout():
	character_pos += 1
	text = full_text.substr(0, character_pos)
	$TextSound.play()
	if character_pos == full_text.length():
		$Timer.stop()
