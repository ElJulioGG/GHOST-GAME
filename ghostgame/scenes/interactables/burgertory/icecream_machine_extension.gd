extends Interactable

@export_category("Icecream Machine")
@export var _minigameScene : PackedScene
var _minigameRef = null

func _call_icecream_minigame() -> void:
	if globalScript._currentPlayer._currentPickup != null:
		return
	
	globalScript._currentPlayer._canAct = false
	print("calling icecream minigame...")
	
	var newMinigame = _minigameScene.instantiate()
	self.add_child(newMinigame)
	_minigameRef = newMinigame
	_minigameRef._interactableParent = self
	

func _icecream_minigame_over(value : int) -> void:
	
	match value:
		0: 
			print()
		1:
			globalScript._currentPlayer._give_pickup_to_player("res://scenes/pickups/icecream_pickup.tscn")
		2:
			globalScript._currentPlayer._give_pickup_to_player("res://scenes/pickups/bad_icecream_pickup.tscn")
	
	self.remove_child.call_deferred(_minigameRef)
	_minigameRef.queue_free()
	globalScript._currentPlayer._canAct = true
	_canInteract = true

func _ready() -> void:
	_whenInteracted = _call_icecream_minigame
