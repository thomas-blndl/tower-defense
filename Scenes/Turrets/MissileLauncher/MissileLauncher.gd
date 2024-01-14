class_name MissileLauncher
extends Turret

func _ready():
	super()
	ammo = preload("res://Scenes/Turrets/MissileLauncher/missile.tscn")
	shoot_cooldown = 2
	price = 100
