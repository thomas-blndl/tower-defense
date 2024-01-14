extends TileMap

@onready var gameManager = $"../GameManager"
var grid_size_x
var grid_size_y
var dic = {}
var selected_cell
var is_building = false

func _ready():
	var grid_size = get_used_rect().size * rendering_quadrant_size
	grid_size_x = grid_size[0]
	grid_size_y = grid_size[1]
	for x in grid_size_x:
		for y in grid_size_y:
			dic[str(Vector2(x,y))] = {
				"Type" = "Tile",
				"Position" = str(Vector2(x,y))
			}

func _process(delta):
	if !gameManager.is_game_over && is_building:
		handle_input()
		var tile = local_to_map(get_global_mouse_position())
		
		if selected_cell:
			erase_cell(1, selected_cell)
			
		if dic.has(str(tile)):
			set_cell(1, tile, 1, Vector2i(0,0), 0)
			selected_cell = tile

func handle_input():
	if Input.is_action_just_pressed("LeftClick"):
		set_cell(0, selected_cell, 6, Vector2i(0,0), 0)
