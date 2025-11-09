extends Interactable


func _recieve_trash():
	if globalScript._currentPlayer._currentPickup != null:
		globalScript._currentPlayer.remove_child(globalScript._currentPlayer._currentPickup)
		globalScript._currentPlayer._currentPickup = null
	
	_canInteract = true

func _ready() -> void:
	_whenInteracted = _recieve_trash
