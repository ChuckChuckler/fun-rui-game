extends Control

var index = 0

var texts = [
	"My name is Tenma Tsukasa.",
	"I am a man destined for greatness...",
	"...For stardom!",
	"No challenge or obstacle can hold a candle to my brilliance!",
	"After all, I am--"
]

@onready var text = $text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$typewriterTimer.timeout.connect(stop_sound)
	update_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next() -> void:
	index+=1
	if index==texts.size():
		$".".visible=false
		$"../vn".visible=true
		$"../vn".run_process()
	else:
		update_text()

func update_text():
	$AudioStreamPlayer.play()
	$typewriterTimer.start()
	text.text=texts[index]
	text.visible_ratio=0.0
	var tween:Tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1.0, 2.0).from(0.0)
	

func stop_sound():
	$AudioStreamPlayer.stop()


func _on_skip_vn_pressed() -> void:
	$"../black".visible=true
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time=2
	timer.one_shot=true
	timer.timeout.connect(next_scene)
	timer.start()
	create_tween().tween_property($"../black", "color", Color(0,0,0,1),2)

func next_scene():
	get_tree().change_scene_to_file("res://node_2d.tscn")
