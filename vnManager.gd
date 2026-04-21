extends Control

@onready var kasa = $tsukaka
@onready var rui = $rui
@onready var nameDisplay = $text/nameDisplay/name
@onready var dialogue = $text/textDisplay/dialogue

var ruiDefaultSize=null;
var ruiLarger=null;

var kasaDefaultSize=null;
var kasaLarger=null;

const toIncrease=15

var index=0
var lines = [
	["Tsukasa", "..."],
	["Tsukasa", "A ZERO?!"],
	["Tsukasa", "This cannot be...it simply cannot be..."],
	["Tsukasa", "But how did I fail so miserably? I studied for hours!"],
	["Tsukasa", "What kind of future star am I..."],
	["Rui", "Tsukasa-kun?"],
	["Tsukasa", "Uwoh! R-Rui!"],
	["Rui", "Hello..."],
	["Rui", "How did the physics test go?"],
	["Tsukasa", "..."],
	["Rui", "...oh my."],
	["Rui", "...well, I suppose a zero is...impressive in its own way..."],
	["Tsukasa", "Rui, you gotta help me!"],
	["Tsukasa", "I can't fail again!"],
	["Rui", "Hmm..."],
	["Rui", "Then why not study with me today?"],
	["Tsukasa", "REALLY?!"],
	["Rui", "Why not? I'll let you off once you answer enough questions correctly."],
	["Tsukasa", "Yes! You're the best!"],
	["Tsukasa", "But what if I get too many wrong?"],
	["Rui", "..."],
	["Rui", "In that case..."],
	["Rui", "In that case, I'll have you try out my brand new human-sized confetti canon!"],
	["Rui", "Doesn't that sound fun?"],
	["Tsukasa", "..."],
	["Tsukasa", "...Tenma Tsukasa, start praying."]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ruiDefaultSize=Vector2(rui.size.x, rui.size.y)
	ruiLarger=Vector2(rui.size.x+toIncrease, rui.size.y+toIncrease)
	kasaDefaultSize=Vector2(kasa.size.x, kasa.size.y)
	kasaLarger=Vector2(kasa.size.x+toIncrease, kasa.size.y+toIncrease)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func run_process():
	$gong.play()
	kasa.visible=false
	update_dialogue()

func _next_dialogue() -> void:
	index+=1
	if index==2:
		$tsucacaFail.visible=false
		$kamiyamaBg.visible=true
		$meepcity.play()
		kasa.visible=true
	
	if index==22:
		kasa.visible=false
		rui.visible=false
		$ruisCannon.visible=true
		$boom.play()
	
	if index==24:
		kasa.visible=true
	
	if index==lines.size():
		$black.visible=true
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time=2
		timer.one_shot=true
		timer.timeout.connect(next_scene)
		timer.start()
		create_tween().tween_property($black, "color", Color(0,0,0,1),2)
		create_tween().tween_property($meepcity,"volume_db",-100,2)
	else:
		update_dialogue()

func next_scene():
	get_tree().change_scene_to_file("res://node_2d.tscn")

func update_dialogue():
	if lines[index][0]=="Rui":
		if !rui.is_visible_in_tree():
			rui.visible=true
	
	nameDisplay.text=lines[index][0]
	dialogue.text=lines[index][1]
	create_tween().tween_property(dialogue, "visible_ratio", 1.0, 1.0).from(0.0)
