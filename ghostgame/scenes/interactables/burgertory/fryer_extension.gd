extends Interactable

@export_category("Fryer")
@export var _fryTimer : Timer
@export var _burnTimer : Timer
@export var _ASP : AudioStreamPlayer

@export var _onTime : bool = false

func _start_frying() -> void:
	_animSprite.play("frying")
	_fryTimer.start()
	_ASP.play()
	# instantiate progress bar, give it same time as fry timer

func _on_fryer_timer_timeout() -> void:
	_animSprite.play("goodFries")
	_burnTimer.start()
	_onTime = true
	_whenInteracted = _pickup_fries
	_canInteract = true

func _on_burnt_timer_timeout() -> void:
	_animSprite.play("badFries")
	_onTime = false

func _pickup_fries() -> void:
	
	if globalScript._currentPlayer._currentPickup != null:
		return
	
	_burnTimer.stop()
	
	if _onTime:
		globalScript._currentPlayer._give_pickup_to_player("res://scenes/pickups/fries_pickup.tscn")
	else:
		globalScript._currentPlayer._give_pickup_to_player("res://scenes/pickups/bad_fries_pickup.tscn")
	
	_animSprite.play("idle")
	_whenInteracted = _start_frying
	_canInteract = true

func _ready() -> void:
	_animSprite.play("idle")
	_whenInteracted = _start_frying
