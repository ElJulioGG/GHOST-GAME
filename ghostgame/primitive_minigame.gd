extends Node2D

@export_category("nodos necesarios")
@export var _excededTimer: Timer
@export var _completedTimer: Timer
@export var _xButton: Button
@export var _heladoButton: Button

func _on_button_2_button_up() -> void:
	print("dejado de presionar")
	print(_excededTimer.time_left)
	_excededTimer.paused = true
	_completedTimer.paused = true


func _on_button_2_button_down() -> void:
	_excededTimer.start()
	_completedTimer.start()
	print("helado")


func _on_progress_timer_timeout() -> void:
	print("chorreao")
	_heladoButton.disabled = true
	


func _on_completed_timer_timeout() -> void:
	print("helado lleno") # Replace with function body.


func _on_x_button_pressed() -> void:
	pass # Replace with function body.
