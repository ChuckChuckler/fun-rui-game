extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func cannonImpending():
	$".".texture=load("res://tsukasa mini head/CANNON.png")
	$AnimationPlayer.play("NOOCANNON")

func almostThere():
	$".".texture=load("res://tsukasa mini head/oh yeah.png")

func neutral():
	$".".texture=load("res://tsukasa mini head/neutral.png")
	$AnimationPlayer.play("idle")
