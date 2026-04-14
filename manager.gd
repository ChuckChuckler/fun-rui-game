extends Node2D

const g=9.8

@onready var rui = $"../bg/rui"
@onready var problemDisplay = $"../bg/board/problem"

var ans=0

var rng = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	createProblem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func createProblem():
	#var choice = rng.randi_range(1,3)
	var choice=1
	if choice==1:
		#var type=rng.randi_range(1,3)
		var type=1
		if type==1:
			var toGetT=rng.randi_range(1,2)
			if toGetT==1:
				var numCycles=randi_range(5,30)
				var numSeconds=randi_range(10,25)
				var k=roundToDec(randf_range(20.0,200.0),2)
				ans=solveForM((numCycles*1.0)/numSeconds, k)
				problemDisplay.text=str("An unknown mass hangs from a spring with a spring constant of ", k, "N/m. The spring completes ", numCycles, " cycles in ", numSeconds, " seconds. What is the mass, in kg, of the weight?")
			else:
				var l = roundToDec(randf_range(0.1, 0.5),1)
				var k=roundToDec(randf_range(20.0,200.0),2)
				ans=solveForM(2*PI*(sqrt(l/g)), k)
				problemDisplay.text=str("An unknown mass hangs from a spring with a spring constant of ", k, "N/m. The spring stretches ", l, " m. What is the mass, in kg, of the weight?")
			
				
func solveForM(t, k):
	return k*pow(t/(2*PI),2)
	
func roundToDec(x, digit):
	return round(x*pow(10.0,digit))/pow(10.0,digit)
	
