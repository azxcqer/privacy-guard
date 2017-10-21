extends Node

onready var grid = get_node("grid")

var cell = preload("res://scenes/cell.tscn")

var grid_index = []
var cell_size = 64
var grid_size = 5

var empty_cell = Vector2(2, 3)

func _ready():
	create_grid()
	set_process_input(true)

func _input(event):
	if (event.is_action_pressed("left_mouse_button")): #verifica se o jogador clicou
		var x = int(event.pos.x / cell_size) #acha o index baseado na posicao do clique e o transform em int (arredonda para baixo)
		var y = int(event.pos.y / cell_size)
		#print(str(x) + " " + str(y))
		if x < grid_size and y < grid_size: #verifica se o jogador clicou dentro do grid
			check_neighbors(x, y) #verifica os vizinhos

func create_grid():
	for i in range(grid_size): # linhas
		grid_index.append([])
		grid_index[i] = [] #cria uma matriz
		for j in range(grid_size): # colunas
			var c = cell.instance() #crie uma instancia de celula
			grid_index[i].append([]) #cria uma matriz na matriz
			grid_index[i][j] = c #adiciona essa cell na linha i e na coluna j
			grid.add_child(c) #adiciona a cell ao grid
			c.set_pos(Vector2(i * cell_size, j * cell_size)) #define a posicao da cell
			if i == empty_cell.x and j == empty_cell.y: #verifica se essa cell que acabou de ser instanciada eh a cell vazia
				c.set_empty() #define ela como vazia -- funcao em cell.gd

func check_neighbors(x, y):	
	if y - 1 >= 0: #se o topo nao for fora do grid
		if grid_index[x][y-1].is_empty:
			change_cell_position(x, y, x, y-1)
	if y + 1 <= grid_size - 1: # se a cell de baixo nao for fora do grid
		if grid_index[x][y+1].is_empty:
			change_cell_position(x, y, x, y+1)
	if x - 1 >= 0: #se a esquerda nao for fora do grid
		if grid_index[x-1][y].is_empty:
			change_cell_position(x, y, x-1, y)
	if x + 1 <= grid_size -1: #se a ireita nao for fora do grid
		if grid_index[x+1][y].is_empty:
			change_cell_position(x, y, x+1, y)

func change_cell_position(x, y, u, v): #troca a posicao da cell clicada com a celula vazia
	var new_pos = Vector2()
	var empty
	new_pos = grid_index[u][v].get_pos()
	grid_index[u][v].set_pos(grid_index[x][y].get_pos())
	grid_index[x][y].set_pos(new_pos)
	empty = grid_index[u][v]
	grid_index[u][v] =  grid_index[x][y]
	grid_index[x][y] = empty