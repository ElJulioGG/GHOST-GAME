extends Node2D

@export_category("nodos necesarios")
@export var _excededTimer: Timer
@export var _completedTimer: Timer
@export var _xButton: Button
@export var _cookButton: Button
@export var _hambButton: Button
@export var _lechuButton: Button
@export var _tomButton: Button
@export var _quesButton: Button

var compl = 0

var ingredientes: Array[String] = ["tomate", "queso", "hamburguesa", "lechuga"]
var lista: Array[String] = []
var ordenar: Array[String] = []

func _on_burguer_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		print("cocina encendida")
		_excededTimer.start()
		_completedTimer.start()
	else:
		print("cocina apagada")
		_excededTimer.paused = true
		_completedTimer.paused = true

func _on_cocido_timer_timeout() -> void:
	print("cocinado")

func _on_quemado_timer_timeout() -> void:
	print("quema quema")
	_cookButton.disabled = true

func _on_x_button_pressed() -> void:
	lista = ingredientes.duplicate()
	lista.shuffle()
	print("Lista mandada")
	print(lista)

func _on_lechuga_pressed() -> void:
	ordenar.append("lechuga") # Replace with function body.
	_lechuButton.disabled = true

func _on_queso_pressed() -> void:
	ordenar.append("queso") # Replace with function body.
	_quesButton.disabled = true

func _on_hamburguesa_pressed() -> void:
	ordenar.append("hamburguesa") # Replace with function body.
	_hambButton.disabled = true

func _on_tomate_pressed() -> void:
	ordenar.append("tomate") # Replace with function body.
	_tomButton.disabled = true

func _on_mandar_pressed() -> void:
	print("lista: ", lista)
	print("miorden: ", ordenar)
	compl = 1
	for i in range(4):
		if lista[i] != ordenar[i]:
			print("diferente")
			compl = 0
			break # Replace with function body.
	if compl == 1:
		print("lista completada")

func _on_reset_pressed() -> void:
	ordenar = []
	_tomButton.disabled = false
	_lechuButton.disabled = false
	_quesButton.disabled = false
	_hambButton.disabled = false
