extends Sprite2D

var max_health = 100
var health = max_health

signal updateBaseHealthBar(health)
signal game_over()

func _ready():
	updateBaseHealthBar.emit(health)

func update_health(damage):
	health -= damage
	if health <= 0:
		game_over.emit()
	updateBaseHealthBar.emit(health)
