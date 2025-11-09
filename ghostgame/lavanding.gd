extends Node2D

@export_category("nodos necesarios")
@export var _encender: Button
@export var _llenar: Button
@export var _reiniciar: Button
@export var _minimo: Timer
@export var _maximo: Timer
@export var _lavar: Timer

var _state = 0

func _on_minimo_timeout() -> void:
	print("Lleno")
	_state = 2

func _on_maximo_timeout() -> void:
	print("Excedido")
	_state = 3
	_llenar.disabled = true
	_reiniciar.disabled = false

func _on_llenar_detergente_button_up() -> void:
	_minimo.paused = true
	_maximo.paused = true
	print(_maximo.time_left)
	print(_state)

func _on_llenar_detergente_button_down() -> void:
	if _state == 0:
		_minimo.start()
		_maximo.start()
		_state = 1
	else:
		_minimo.paused = false
		_maximo.paused = false

func _on_reiniciar_llenado_pressed() -> void:
	_state = 0
	_reiniciar.disabled = true
	_llenar.disabled = false

func _on_encender_pressed() -> void:
	_lavar.start()
	_llenar.disabled = true
	_encender.disabled = true

func _on_lavar_timeout() -> void:
	if _state == 2:
		print("lavado excitoso")
	elif _state == 3:
		print("lavado excedido")
	else:
		print("lavado insuficiente")
