extends Interactable

@export_category("Frying essentials")
@export var _fryTimer : Timer
@export var _burnTimer : Timer

@export var _onTime : bool = true

func _start_frying() -> void:
	print("friendo papas...")
	_onTime = true
	_fryTimer.start()
	# instantiate progress bar, give it same time as fry timer

func _on_fryer_timer_timeout() -> void:
	print("PAPAS FRITAS!!!!!")
	_burnTimer.start()
	_whenInteracted = _pickup_fries
	_canInteract = true

func _on_burnt_timer_timeout() -> void:
	print("se quemaron las papas...")
	_onTime = false

func _pickup_fries() -> void:
	if _onTime:
		_burnTimer.stop()
		print("papas buenas")
	else:
		_burnTimer.stop()
		print("papas malas")
	
	_whenInteracted = _start_frying
	_canInteract = true

func _ready() -> void:
	_whenInteracted = _start_frying
