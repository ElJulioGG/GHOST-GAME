extends Interactable

@export_category("Burger stand")
@export var _minigameScene : PackedScene
var _minigameRef = null

func _call_burger_minigame() -> void:
	if globalScript._currentPlayer._currentPickup != null:
		return

	globalScript._currentPlayer._canAct = false
	print("calling burger minigame...")
	
	var newMinigame = _minigameScene.instantiate()
	self.add_child(newMinigame)
	_minigameRef = newMinigame
	_minigameRef._interactableParent = self
	_minigameRef.global_position = Vector2(144,280)

func _burger_minigame_over(value : int)-> void:
	
	match value:
		0:
			print("nada pasa!")
		1:
			print("minijuego bueno")
		2:
			print("minijuego malo")
	
	self.remove_child(_minigameRef)
	_minigameRef.queue_free()
	globalScript._currentPlayer._canAct = true
	_canInteract = true

func _ready() -> void:
	_whenInteracted = _call_burger_minigame
