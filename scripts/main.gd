extends Node

onready var grid = get_node("grid")

var cell = preload("res://scenes/cell.tscn")

var grid_index = []
var cell_size = 32
var grid_size = 5

var empty_cell = Vector2(2, 3)

func _ready():
	create_grid()
	set_process_input(true)

func _input(event):
	if (event.is_action_pressed("left_mouse_button")):
		var x = int(event.pos.x / cell_size)
		var y = int(event.pos.y / cell_size)
		#print(str(x) + " " + str(y))
		if x < grid_size and y < grid_size:
			check_neighbors(x, y)

func create_grid():
	var children = grid.get_children()
	for i in range(grid_size):
		grid_index.append([])
		grid_index[i] = []
		for j in range(grid_size):
			var c = cell.instance()
			grid_index[i].append([])
			grid_index[i][j] = c
			grid.add_child(c)
			c.set_pos(Vector2(i * cell_size, j * cell_size))
			if i == empty_cell.x and j == empty_cell.y:
				c.set_empty()

func check_neighbors(x, y):
	var new_pos = Vector2()
	var empty
	
	if y - 1 >= 0: #se o topo não for fora do grid
		if grid_index[x][y-1].is_empty:
			new_pos = grid_index[x][y-1].get_pos()
			grid_index[x][y-1].set_pos(grid_index[x][y].get_pos())
			grid_index[x][y].set_pos(new_pos)
			empty = grid_index[x][y-1]
			grid_index[x][y-1] =  grid_index[x][y]
			grid_index[x][y] = empty
	if y + 1 <= grid_size - 1:
		if grid_index[x][y+1].is_empty:
			new_pos = grid_index[x][y+1].get_pos()
			grid_index[x][y+1].set_pos(grid_index[x][y].get_pos())
			grid_index[x][y].set_pos(new_pos)
			empty = grid_index[x][y+1]
			grid_index[x][y+1] =  grid_index[x][y]
			grid_index[x][y] = empty
	if x - 1 >= 0:
		if grid_index[x-1][y].is_empty:
			new_pos = grid_index[x-1][y].get_pos()
			grid_index[x-1][y].set_pos(grid_index[x][y].get_pos())
			grid_index[x][y].set_pos(new_pos)
			empty = grid_index[x-1][y]
			grid_index[x-1][y] =  grid_index[x][y]
			grid_index[x][y] = empty
	if x + 1 <= grid_size -1:
		if grid_index[x+1][y].is_empty:
			new_pos = grid_index[x+1][y].get_pos()
			grid_index[x+1][y].set_pos(grid_index[x][y].get_pos())
			grid_index[x][y].set_pos(new_pos)
			empty = grid_index[x+1][y]
			grid_index[x+1][y] =  grid_index[x][y]
			grid_index[x][y] = empty
	