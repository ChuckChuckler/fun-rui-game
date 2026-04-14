extends Node2D

const g=9.8

@onready var rui = $"../bg/rui"
@onready var problemDisplay = $"../bg/board/problem"
@onready var answer = $"../bg/board/answer"
@onready var feedback = $"../bg/board/feedback"

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
	#var choice = rng.randi_range(1,2)
	var choice=1
	if choice==1: #spring related questions
		var type=rng.randi_range(1,6)
		#var type=6
		var numCycles=randi_range(5,30)
		var numSeconds=randi_range(10,25)
		var t=(numSeconds*1.0)/numCycles
		if type==1: #solve for mass!!!
			var k=roundToDec(randf_range(20.0,200.0),2)
			ans=k*pow(t/(2*PI),2)
			problemDisplay.text=str("An unknown mass hangs from a spring with a spring constant of ", k, "N/m. The spring completes ", numCycles, " oscillations in ", numSeconds, " seconds. What is the mass, in kg, of the weight?")
		elif type==2: #solve for k
			var m=roundToDec(randf_range(0.1,2), 2)
			ans=m*pow((2*PI)/t,2)
			problemDisplay.text=str("A mass of ", m, "kg hangs from a spring and the spring oscillates. The spring completes ", numCycles, " oscillations in ", numSeconds, " seconds. What is the spring constant?")
		elif type==3: #solve for x
			var m=roundToDec(randf_range(0.1,2), 2)
			var k=m*pow((2*PI)/t,2)
			var whichEquation=rng.randi_range(1,2)
			if whichEquation==1:
				var PE = randi_range(10,500)
				ans=sqrt((2.0*PE)/k)
				problemDisplay.text=str("A spring dangles a mass of ", m, "kg, and the spring fully oscillates ", numCycles, " times in ", numSeconds, " seconds. The potential energy of the spring is ", PE, " J. How far, in m, does the spring stretch?")
			elif whichEquation==2:
				var F = randi_range(10, 1000)
				ans=F/k
				problemDisplay.text=str("A spring dangles a mass of ", m, "kg, and the spring fully oscillates ", numCycles, " times in ", numSeconds, " seconds. The spring exerts a force of ", F, " N. How far, in m, does the spring stretch?")
		elif type==4: #solve for PE
			var m=roundToDec(randf_range(0.1,2), 2)
			var k=m*pow((2*PI)/t,2)
			var x=roundToDec(randf_range(0.1,0.6), 2)
			ans=(0.5)*k*pow(x, 2)
			problemDisplay.text=str("A spring dangles a mass of ", m, "kg, and the spring fully oscillates ", numCycles, " times in ", numSeconds, " seconds. The spring stretches a maximum of ", x, " m. What is the energy of the system?")
		elif type==5: #solve for F
			var m=roundToDec(randf_range(0.1,2), 2)
			var k=m*pow((2*PI)/t,2)
			var x=roundToDec(randf_range(0.1,0.6), 2)
			ans=k*x
			problemDisplay.text=str("A spring dangles a mass of ", m, "kg, and the spring fully oscillates ", numCycles, " times in ", numSeconds, " seconds. The spring stretches a maximum of ", x, " m. What is the force, in N, of the spring?")
		elif type==6: #solve for h
			var m=roundToDec(randf_range(0.1,2), 2)
			var k=m*pow((2*PI)/t,2)
			var x=roundToDec(randf_range(0.1,0.6), 2)
			var PE=(0.5)*k*pow(x, 2)
			ans=PE/(m*g)
			problemDisplay.text=str("A spring with constant ", roundToDec(k,2), " N/m is compressed ", x, "m. It is released to propel a ", m, "kg object upwards. How high will the object go, ignoring air resistance?")

	elif choice==2: #pendulum related questions
		#var type=rng.randi_range(1,2)
		var type=1
		if type==1: #finding length of pendulum?
			var numCycles=randi_range(5,30)
			var numSeconds=randi_range(10,25)
			var t=(numCycles*1.0)/numSeconds
			ans=g*pow(t/(2*PI),2)
			problemDisplay.text=str("A pendulum completes ", numCycles, " oscillations in ", numSeconds, " seconds. What is the length of the pendulum?")
		
func roundToDec(x, digit):
	return round(x*pow(10.0,digit))/pow(10.0,digit)

func _on_answer_submit() -> void:
	if answer.text!="":
		answer=float(answer)
		if answer>=ans-0.1 && answer<=ans+0.1:
			feedback.text="Correct!"
		else:
			feedback.text="Try again..."
