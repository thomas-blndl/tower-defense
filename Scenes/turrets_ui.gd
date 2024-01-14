extends Control

signal cannonChoosen()
signal machinegunChoosen()
signal missilelauncherChoosen()

@onready var builder_controller = $"../../BuilderController"

func _ready():
	var cannon = Cannon.new()
	var mg = MachineGun.new()
	var ml = MissileLauncher.new()
	cannon._ready()
	mg._ready()
	ml._ready()
	$VBoxContainer/HBoxContainer/CannonButton/Price.text = str(cannon.price)
	$VBoxContainer/HBoxContainer/MachineGunButton/Price.text = str(mg.price)
	$VBoxContainer/HBoxContainer/MissileLauncherButton/Price.text = str(ml.price)

func _on_cannon_button_pressed():
	cannonChoosen.emit()

func _on_machine_gun_button_pressed():
	machinegunChoosen.emit()

func _on_missile_launcher_button_pressed():
	missilelauncherChoosen.emit()
