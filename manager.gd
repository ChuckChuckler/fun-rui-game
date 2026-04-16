extends Node2D

const g=9.8

@onready var rui = $"../bg/rui"
@onready var problemDisplay = $"../bg/board/problem"
@onready var answer = $"../bg/board/answer"
@onready var feedback = $"../bg/board/feedback"
@onready var kasaHeadIncorrect = $"../bg/incorrectAnswers/kasaHead"
@onready var kasaHeadCorrect = $"../bg/correctAnswers/kasaHead"

var ans=0
var firstTimeWrong=true

var incorrectAnswers=0
const totalIncorrects=10

var correctAnswers=0
const totalCorrects=10

var buttonCooldown=false

var rng = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	createProblem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func createProblem():
	var choice = rng.randi_range(1,2)
	choice=2
	if choice==1: #spring related questions
		var type=rng.randi_range(1,6)
		#var type=7
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
			problemDisplay.text=str("A spring dangles a mass of ", m, "kg, and the spring fully oscillates ", numCycles, " times in ", numSeconds, " seconds. When the spring is compressed ", x, " m, what is the energy of the system?")
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
		elif type==7: #solve for v
			var m=roundToDec(randf_range(0.1,2), 2)
			var k=m*pow((2*PI)/t,2)
			var x=roundToDec(randf_range(0.1,0.6), 2)
			var PE=(0.5)*k*pow(x, 2)
			ans=sqrt((2*PE)/m)
			var format=randi_range(1,2)
			if format==1:
				problemDisplay.text=str("A ", m, " kg mass is attached to a spring with a spring constant of ", roundToDec(k,2), " N/m. If the spring is stretched ", x, " m and then released, what will be the maximum speed of the mass?")
			else:
				problemDisplay.text=str("A spring with constant ", roundToDec(k,2), " N/m is compressed a distance of ", x, " m by a ", m, " kg object. When the object is released, how fast will the block move forward?")
	
	elif choice==2: #pendulum related questions
		var type=rng.randi_range(1,6)
		type=5
		if type==1: #solve for length of pendulum
			var numCycles=randi_range(5,30)
			var numSeconds=randi_range(10,25)
			var t=(numSeconds*1.0)/numCycles
			ans=g*pow(t/(2*PI),2)
			problemDisplay.text=str("A pendulum completes ", numCycles, " oscillations in ", numSeconds, " seconds. What is the length of the pendulum?")
		elif type==2: #solve for g i guess???
			var numCycles=randi_range(5,30)
			var numSeconds=randi_range(10,25)
			var t=(numSeconds*1.0)/numCycles
			var l=roundToDec(randf_range(0.1,1),2)
			ans=l*pow((2*PI)/t,2)
			problemDisplay.text=str("On another planet, a ", l, " m long pendulum completes ", numCycles, " oscillations in ", numSeconds, " seconds. What is the gravitational force on this planet?")
		elif type==3: #solve for T
			var l=roundToDec(randf_range(0.1,1),2)
			ans=2*PI*sqrt(l/g)
			problemDisplay.text=str("A pendulum is ", l, " m long. Calculate its period.")
		elif type==4: #solve for F
			var l=roundToDec(randf_range(0.1,1),2)
			ans=1/(2*PI*sqrt(l/g))
			problemDisplay.text=str("A pendulum is ", l, " m long. Calculate its frequency.")
		elif type==5: #solve for s
			var l=roundToDec(randf_range(0.1,1),2)
			var T=2*PI*sqrt(l/g)
			var numCycles=randi_range(5,30)
			ans=numCycles*T
			problemDisplay.text=str("A ", l, " m long pendulum makes ", numCycles, " cycles in how many seconds?")
		elif type==6: #solve for cycles
			var l=roundToDec(randf_range(0.1,1),2)
			var T=2*PI*sqrt(l/g)
			var numSeconds=randi_range(10,25)
			ans=numSeconds/T
			problemDisplay.text=str("In ", numSeconds, " seconds, how many cycles does a ", l, " m long pendulum make?")
		
			
func roundToDec(x, digit):
	return round(x*pow(10.0,digit))/pow(10.0,digit)

func _on_answer_submit() -> void:
	if !buttonCooldown:
		if answer.text!="":
			var userFloat = float(answer.text)
			if userFloat>=ans-0.1 && userFloat<=ans+0.1:
				feedback.text=""
				correctAnswers+=1
				kasaHeadCorrect.set_position(Vector2(($"../bg/correctAnswers".size.x*((correctAnswers*1.0)/totalCorrects)),kasaHeadCorrect.position.y))
				feedback.push_color(Color(0.0, 0.677, 0.0, 1.0))
				feedback.add_text("Correct!")
				$"../hooray".play()
				confetti()
				buttonCooldown=true
				var timer = Timer.new()
				add_child(timer)
				timer.wait_time=3
				timer.one_shot=true
				timer.timeout.connect(nextProblem)
				timer.start()
				
			else:
				if firstTimeWrong:
					incorrectAnswers+=1
					kasaHeadIncorrect.set_position(Vector2(($"../bg/incorrectAnswers".size.x*((incorrectAnswers*1.0)/totalIncorrects)),kasaHeadIncorrect.position.y))
					#firstTimeWrong=false
				
				if incorrectAnswers==totalIncorrects:
					$"../bg".visible=false
					$"../gameLose".visible=true
				else:
					feedback.text=""
					feedback.push_color(Color(1,0,0))
					feedback.add_text("Try again...")
					$"../bungebob".play()
					$"../awww".play()

func confetti():
	var confettiTextures = [
		load("res://confetti/red.png"),
		load("res://confetti/blue.png"),
		load("res://confetti/yellow.png")
	]
	
	for i in range(100):
		var confettiPiece = Sprite2D.new()
		confettiPiece.texture=confettiTextures[randi_range(0,confettiTextures.size()-1)]
		confettiPiece.position=Vector2(randf_range(0, get_viewport().size.x),0)
		confettiPiece.scale=Vector2(randf_range(0.02, 0.05),randf_range(0.02, 0.05))
		$"../bg".add_child(confettiPiece)
		var tween=create_tween()
		var velocity = Vector2(randf_range(0,1156),randf_range(100,300))
		tween.tween_property(confettiPiece, "position",velocity, 1)
		tween.parallel().tween_property(confettiPiece,"modulate:a",0.0,1).set_delay(0.5)

func nextProblem():
	if correctAnswers==totalCorrects:
		$"../bg".visible=false
		$"../gameWin".visible=true
	else:
		createProblem()
		feedback.text=""
		answer.text=""
		buttonCooldown=false
