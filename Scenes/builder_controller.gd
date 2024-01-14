extends Node2D

@onready var gold_controller = $"../GoldController"

const CANNON = preload("res://Scenes/Turrets/Cannon/cannon.tscn")
const MACHINEGUN = preload("res://Scenes/Turrets/MachineGun/MachineGun.tscn")
const MISSILELAUNCHER = preload("res://Scenes/Turrets/MissileLauncher/MissileLauncher.tscn")
var selected
var objects_colliding:Array
var canPlace = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var turretsUI = $"../CanvasLayer/TurretsUI"
	turretsUI.cannonChoosen.connect(chooseCannon)
	turretsUI.machinegunChoosen.connect(chooseMachinegun)
	turretsUI.missilelauncherChoosen.connect(chooseMissileLauncher)

func _physics_process(delta):
	if selected != null:
		selected.global_position = get_global_mouse_position()
	manage_placement()

func _process(delta):
	#Click with turret to place it
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && selected != null && canPlace && gold_controller.gold_ammount >= selected.price:
		selected.is_active = true
		selected.get_node("CanPlaceUI").hide()
		gold_controller.remove_gold(selected.price)
		selected = null
	if selected != null:
		var selected_stylebox = StyleBoxFlat.new()
		selected_stylebox.set_corner_radius_all(1024)
		selected_stylebox.anti_aliasing_size = 0.1
		if objects_colliding.size() == 0:
			selected_stylebox.bg_color = Color(0, 1, 0, 0.745)
			canPlace = true
		else:
			selected_stylebox.bg_color = Color(1, 0, 0, 0.745)
			canPlace = false
		selected.get_node("CanPlaceUI").add_theme_stylebox_override("panel", selected_stylebox)

func chooseCannon():
	if selected != null:
		selected.queue_free()
	selected = CANNON.instantiate()
	selected.get_node("Size").body_entered.connect(_on_area_2d_body_entered)
	selected.get_node("Size").body_exited.connect(_on_area_2d_body_exited)
	get_parent().add_child(selected)

func chooseMachinegun():
	if selected != null:
		selected.queue_free()
	selected = MACHINEGUN.instantiate()
	selected.get_node("Size").body_entered.connect(_on_area_2d_body_entered)
	selected.get_node("Size").body_exited.connect(_on_area_2d_body_exited)
	get_parent().add_child(selected)

func chooseMissileLauncher():
	if selected != null:
		selected.queue_free()
	selected = MISSILELAUNCHER.instantiate()
	selected.get_node("Size").body_entered.connect(_on_area_2d_body_entered)
	selected.get_node("Size").body_exited.connect(_on_area_2d_body_exited)
	get_parent().add_child(selected)

func manage_placement():
	if selected != null:
		if selected.get_node("Area2D"):
			pass

func _on_area_2d_body_entered(body):
	if body != selected && !body.get_groups().has("Enemy"):
		objects_colliding.push_front(body)

func _on_area_2d_body_exited(body):
	if objects_colliding.has(body):
		objects_colliding.erase(body)
