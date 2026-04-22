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
	["Tsukasa", "...", load("res://TsukasaVnSprites/tsucacaFail.png")],
	["Tsukasa", "A ZERO?!", load("res://TsukasaVnSprites/tsucacaFail.png")],
	["Tsukasa", "This cannot be...it simply cannot be...", load("res://TsukasaVnSprites/tsucacaFail.png")],
	["Tsukasa", "But how did I fail so miserably? I studied for hours!", load("res://TsukasaVnSprites/tsucacaGrr.png")],
	["Tsukasa", "What kind of future star am I...", load("res://TsukasaVnSprites/tsucacaSad.png")],
	["Rui", "Tsukasa-kun?", load("res://RuiVnSprites/ruiDefault.png")],
	["Tsukasa", "Uwoh! R-Rui!", load("res://TsukasaVnSprites/tsucacaNoway.png")],
	["Rui", "Hello...", load("res://RuiVnSprites/ruiWave.png")],
	["Rui", "How did the physics test go?", load("res://RuiVnSprites/ruiDefault.png")],
	["Tsukasa", "...", load("res://TsukasaVnSprites/tsucacaSad.png")],
	["Rui", "...oh my.", load("res://RuiVnSprites/ruiOh.png")],
	["Rui", "...well, I suppose a zero is...impressive in its own way...", load("res://RuiVnSprites/ruiShrug.png")],
	["Tsukasa", "Rui, you gotta help me!", load("res://TsukasaVnSprites/tsucacaPlsss.png")],
	["Tsukasa", "I can't fail again!", load("res://TsukasaVnSprites/tsucacaPlsss.png")],
	["Rui", "Hmm...", load("res://RuiVnSprites/ruiThink.png")],
	["Rui", "Then why not study with me today?", load("res://RuiVnSprites/ruiDefault.png")],
	["Tsukasa", "REALLY?!", load("res://TsukasaVnSprites/tscacaHappi.png")],
	["Rui", "Why not? I'll let you off once you answer enough questions correctly.", load("res://RuiVnSprites/ruiThumbsUp.png")],
	["Tsukasa", "Yes! You're the best!", load("res://TsukasaVnSprites/tsucacaYay.png")],
	["Tsukasa", "But what if I get too many wrong?", load("res://TsukasaVnSprites/tsucacaHmmm.png")],
	["Rui", "...", load("res://RuiVnSprites/ruiThink.png")],
	["Rui", "In that case...",load("res://RuiVnSprites/ruiThink.png")],
	["Rui", "In that case, I'll have you try out my brand new human-sized confetti canon!",load("res://RuiVnSprites/ruiThink.png")],
	["Rui", "Doesn't that sound fun?",load("res://RuiVnSprites/ruiThink.png")],
	["Tsukasa", "...", load("res://TsukasaVnSprites/tsucacaOh.png")],
	["Tsukasa", "...Tenma Tsukasa, start praying.", load("res://TsukasaVnSprites/tsucacaOh.png")]
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
		create_tween().tween_property($meepcity,"volume_db",-50,2)
	else:
		update_dialogue()

func next_scene():
	get_tree().change_scene_to_file("res://node_2d.tscn")

func update_dialogue():
	if lines[index][0]=="Rui":
		if !rui.is_visible_in_tree():
			rui.visible=true
		rui.texture=lines[index][2]
	else:
		kasa.texture=lines[index][2]
		
	nameDisplay.text=lines[index][0]
	dialogue.text=lines[index][1]
	create_tween().tween_property(dialogue, "visible_ratio", 1.0, 1.0).from(0.0)
