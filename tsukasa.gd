extends Sprite2D

@onready var timer = $"../tsukasaTimer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("idle")
	timer.timeout.connect(reset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func correct():
	$".".texture=load("res://tsukasas head/tsukasaCorrect.png")
	$AnimationPlayer.play("correct")
	waitTime(3)

func incorrect():
	$".".texture=load("res://tsukasas head/tsukasaIncorrect.png")
	$AnimationPlayer.play("incorrect")
	waitTime(3)
	

func waitTime(s:int):
	timer.wait_time=s
	timer.one_shot=true
	timer.start()

func reset():
	$".".texture=load("res://tsukasas head/tsukasaNeutral.png")
	$AnimationPlayer.play("idle")
	
