extends Control

@onready var kasa = $tsukaka

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func run_process():
	$startTimer.timeout.connect(start_vn)
	$startTimer.start()

func start_vn():
	kasa.visible=true
