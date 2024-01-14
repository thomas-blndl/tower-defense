class_name Enemy
extends PathFollow2D

signal baseHit(damages)
signal gainGold(ammount)

var speed = 15
var health = 100
var max_health = health
var attack_damage = 10
var healthBar:ProgressBar
var damage = 10
var spawn_cooldown = 5
var gold_value = 10
var gold_controller:Node2D

func _ready():
	healthBar = $CharacterBody2D/HealthBar
	gold_controller = $GoldController
	update_health_bar()

func _physics_process(delta):
	progress += speed * delta
	check_hit_base()

func hit(damages):
	health -= damages
	if health <= 0:
		die()
	else :
		update_health_bar()
		
func update_health_bar():
	healthBar.value = health
	healthBar.max_value = max_health

func check_hit_base():
	if progress_ratio == 1:
		baseHit.emit(damage)
		queue_free()

func die():
	gainGold.emit(gold_value)
	queue_free()
