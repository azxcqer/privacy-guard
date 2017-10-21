extends Node2D

var cena

var pular = false
var pegarItem = false
 
var estado = true # colocar no main
const jogando = true # colocar no main
const perdeu = false # colocar no main


func _ready():
	set_process_input(true)
	cena = get_tree().get_current_scene()
	
func _input(event):
	if event.is_action_pressed("jump"):
		pular()

func pular():
	if cena.estado == cena.jogando:
		print("pula")  # Teste
