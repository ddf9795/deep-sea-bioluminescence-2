extends Spatial

var axiom
var state
var nextState

var SEED = 'X'
const NUM_GENERATIONS = 3
const TRANSFORMATIONS = {
#	'X': 'C+]]Y[[[++Y[[B',
	'X': 'C>>+]]]]Y<-[[[[[[Y>+X',
	'Y': 'B<<-X>-]]Y',
#	'Y': 'B]]]Y+[X++Y',
#	'F': 'F',
	'>': '>',
	'<': '<',
	'+': '+',
	'-': '-',
	'[': '[',
	']': ']',
	'C': 'C',
	'B': 'B',
}

var _rand = ["X", "Y", '<', '>', "[", "]", "+", "-"]

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	for y in range(30):
		var base = preload("res://Plant.tscn").instance()
		add_child(base)
		base.translation = $Position3D.translation
		base.translation.x += rand_range(-200, 200)
		base.translation.z += rand_range(-200, 200)
		state = base.get_data()
		nextState = state
		
		SEED = "X"
		for x in range(5):
			SEED += _rand[rand_range(0, _rand.size())]
		
		axiom = SEED
		for i in range(NUM_GENERATIONS):
			var newString = "";
			for j in range(axiom.length()):
				newString += TRANSFORMATIONS[axiom[j]]
			axiom = newString
#			print(axiom)
		
		var colorIntensity = 0
		var depth = 0
		for i in range(axiom.length()):
			if axiom[i] == 'C':
				colorIntensity += 5
				depth = 0
			if axiom[i] == 'B':
				depth += 1
			RULES(axiom[i], colorIntensity, depth)

func emptyFunction(i):
	pass
func Function_LengthUp(i, j):
	nextState.length += 0.1
func Function_LengthDown(i, j):
	nextState.length -= 0.1
func Function_SpeedUp(i, j):
	nextState.speed += 0.1
func Function_SpeedDown(i, j):
	nextState.speed -= 0.1
func Function_ArbitraryAngleUp(i, j):
	nextState.arbitraryAngle += Vector3(15, 15, 15)
func Function_ArbitraryAngleDown(i, j):
	nextState.arbitraryAngle -= Vector3(15, 15, 15)
func Function_CreateMain(i, j):
	if is_instance_valid(nextState.ref):
		var newPlant = nextState.ref.createPlant(false, nextState.ref.rotation, nextState.arbitraryAngle, nextState.speed, nextState.length, i, j)
		state = nextState.ref.get_data()
		nextState = newPlant.get_data()
func Function_CreateBranch(i, j):
	if is_instance_valid(nextState.ref):
		var newPlant = nextState.ref.createPlant(true, nextState.ref.rotation, nextState.arbitraryAngle, nextState.speed, nextState.length, i, j)
		match randi() % 2:
			0:
				newPlant.rotation_degrees += Vector3(15,15,15)
			1:
				newPlant.rotation_degrees -= Vector3(15,15,15)
		state = nextState.ref.get_data()
	

func RULES(_char, i,j):
	match _char:
		'X': emptyFunction(i)
		'Y': emptyFunction(i)
		'>': Function_LengthUp(i, j)
		'<': Function_LengthDown(i, j)
		'+': Function_SpeedUp(i,j)
		'-': Function_SpeedDown(i,j)
		'[': Function_ArbitraryAngleUp(i,j)
		']': Function_ArbitraryAngleDown(i,j)
		'C': Function_CreateMain(i,j)
		'B': Function_CreateBranch(i,j)
