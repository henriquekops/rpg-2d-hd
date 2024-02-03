extends SpringArm3D


# Called when the node enters the scene tree for the first time.
func _ready():
	spring_length = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_camera()
	handle_zoom()

func handle_camera():
	if Input.is_action_just_pressed("rotate_left"):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y - PI/2, 0.5)
	elif Input.is_action_just_pressed("rotate_right"):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y - PI/2, 0.5)
	elif (Input.is_action_just_pressed("rotate_right") and Input.is_action_just_pressed("rotate_left")):
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", PI, 0.5)

func handle_zoom():
	if Input.is_action_just_pressed("zoom_in"):
		if spring_length >= 5:
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_OUT)
			var newLength = spring_length - 1
			tween.tween_property(self, "spring_length", newLength, 0.5)
			tween.set_parallel(true)
			if newLength <= 0:
				tween.tween_property(self, "position", Vector3(0, 0.2, 0), 0.5)
	elif Input.is_action_just_pressed("zoom_out"):
		if spring_length <= 10:
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_OUT)
			var newLength = spring_length + 1
			tween.tween_property(self, "spring_length", newLength, 0.5)
			tween.set_parallel(true)
			if newLength < 0:
				tween.tween_property(self, "position", Vector3(0, 0.2, 0), 0.5)
