class_name MachineGun
extends Turret

func _ready():
	super()
	ammo = preload("res://Scenes/Turrets/MachineGun/bulletMG.tscn")
	shoot_cooldown = 0.3
	price = 75
