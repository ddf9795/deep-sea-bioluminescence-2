extends Camera

var target = Vector3.ONE

func _input(event):
	if event is InputEventMouseMotion:
		target += Vector3(-event.relative.y, -event.relative.x, 0)
		rotation_degrees = target
		rotation_degrees.x = clamp(rotation_degrees.x, -80, 80)
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE and event.pressed:
			get_tree().quit()
		if event.scancode == KEY_LEFT and event.pressed:
			translate_object_local(Vector3(-1,0,0))
		if event.scancode == KEY_RIGHT and event.pressed:
			translate_object_local(Vector3(1,0,0))
		if event.scancode == KEY_UP and event.pressed:
			translate_object_local(Vector3(0,0,-1))
		if event.scancode == KEY_DOWN and event.pressed:
			translate_object_local(Vector3(0,0,1))
		if translation.y <= -120: translation.y = -120
