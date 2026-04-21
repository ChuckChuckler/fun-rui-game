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
	text.text=texts[index]
	text.visible_ratio=0.0
	var tween:Tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1.0, 2.0).from(0.0)
	
