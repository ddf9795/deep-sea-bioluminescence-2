extends Sprite3D

var next = []

var branch = false

export var speed = 1.0
export var length = 1.0
export var arbitraryAngle = Vector3.ZERO
export var brightness = 255

func get_data():
	return {
		'ref': self,
		'branch': branch,
		'rotation': rotation,
		'speed': speed,
		"length": length,
		"arbitraryAngle": arbitraryAngle,
		'brightness': brightness
	}

func createPlant(_branch, _angle, _arbitraryAngle, _speed, _length, colorIntensity, depth):
	var newPlant = load("res://Plant.tscn").instance()
	add_child(newPlant) 
	newPlant.branch = _branch
	newPlant.translation = $"%NextStartPos".translation
	newPlant.arbitraryAngle = _arbitraryAngle
	newPlant.rotation = _angle + _arbitraryAngle
	newPlant.speed = _speed
	newPlant.length = _length
	newPlant.brightness = colorIntensity - depth
	
	return newPlant

func _process(delta):
	speed = clamp(speed, -2, 2)
	scale.y = clamp(length, 0.1, 2)
	$"%AltAngle".scale.y = clamp(length, 0.1, 1.1)
#	modulate.r = clamp(brightness, 0, 255)
#	modulate.g = clamp(brightness, 0, 255)
#	modulate.b = clamp(brightness, 0, 255)
	rotate_x((speed / 50.0) * delta)
	rotate_y((speed / 50.0) * delta)
#	rotate_z((speed / 50.0) * delta)
	if branch: next.clear()
	for child in next:
		next.translation = $"%NextStartPos".translation
