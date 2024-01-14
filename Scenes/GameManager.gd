extends Node2D

@onready var base = $"../Base"
@onready var game_over_menu = $"../GameOverMenu"
@onready var gold_controller = $"../GoldController"

const LEZARD = preload("res://Scenes/lezard.tscn")
var can_spawn_lezard = true
var is_game_over = false

func _ready():
	Engine.time_scale = 1
	base.game_over.connect(game_over)
	game_over_menu.hide()

func _process(delta):
	if can_spawn_lezard:
		spawn_lezard()
		
func spawn_lezard():
	can_spawn_lezard = false
	var lezard = LEZARD.instantiate()
	get_parent().get_node("Path2D").add_child(lezard)
	lezard.baseHit.connect(base.update_health)
	lezard.gainGold.connect(gold_controller.add_gold)
	
	await get_tree().create_timer(lezard.spawn_cooldown).timeout
	can_spawn_lezard = true

func game_over():
	is_game_over = true
	game_over_menu.show()
	Engine.time_scale = 0
