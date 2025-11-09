extends Node2D

@export_category("nodos necesarios")
@export var _excededTimer: Timer
@export var _completedTimer: Timer
@export var _closeButton: Button
@export var _fillButton: Button
@export var _pbar : TextureProgressBar

var _filling : bool = false
var _state : int = 0

var _interactableParent : Interactable = null

func _on_fill_button_button_down() -> void:
	_completedTimer.start()
	_filling = true

func _on_fill_button_button_up() -> void:
	_check_status()
	_filling = false

func _on_completed_timer_timeout() -> void:
	_state = 1
	_excededTimer.start()

func _on_exceded_timer_timeout() -> void:
	_state = 2
	_check_status()

func _check_status() -> void:
	_completedTimer.stop()
	_excededTimer.stop()
	_fillButton.disabled = true
	
	match _state:
		0:
			_interactableParent._icecream_minigame_over(0)
		1:
			_interactableParent._icecream_minigame_over(1)
		2:
			_interactableParent._icecream_minigame_over(2)


func _on_close_button_pressed() -> void:
	_completedTimer.stop()
	_excededTimer.stop()
	_fillButton.disabled = true
	_interactableParent._icecream_minigame_over(0)

func _physics_process(delta: float) -> void:
	if _filling:
		_pbar.value += 0.7
