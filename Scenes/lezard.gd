extends "res://Scenes/enemy.gd"

func _ready():
	super()
	speed = 75
	max_health = 75
	health = max_health
	attack_damage = 10
	spawn_cooldown = 2
	gold_value = 50
	update_health_bar()
