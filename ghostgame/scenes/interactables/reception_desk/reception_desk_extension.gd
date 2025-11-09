extends Interactable

@export_category("Reception Desk")
@export var _clientSprite : Sprite2D 
@export var _orderSprite : Sprite2D 

@export var _orderTimer : Timer
@export var _idleTimer : Timer
@export var _possibleOrders : Array[String]
@export var _orderWeights : Array[float]
var _desiredOrder : String

@export var _ASP1 : AudioStreamPlayer
@export var _ASP2 : AudioStreamPlayer

func _on_idle_timer_timeout() -> void:
	_pick_new_order()
	print(_desiredOrder)

func _pick_new_order() -> void:
	# picking based on weighted probabilities
	var pick : float = globalScript._globalRng.randf_range(1,100)
	for i in range(len(_orderWeights)):
		pick -= _orderWeights[i]
		
		if pick <= 0:
			_desiredOrder = _possibleOrders[i]
			
			# Activate interaction and the ordertimer
			_canInteract = true
			_orderTimer.start()
			
			# picking sprite
			var newSprite = load("res://icon.svg")
			_clientSprite.texture = newSprite
			_clientSprite.visible = true
			_orderSprite.visible = true
			
			return
	
	
	# picking sprite
	var newSprite = load("res://icon.svg")
	_clientSprite.texture = newSprite
	_clientSprite.visible = true
	_orderSprite.visible = true
	
	#failsafe
	_desiredOrder = _possibleOrders[0]
	_canInteract = true
	_orderTimer.start()
	return

func _on_order_timer_timeout() -> void:
	_fail_order()

func _fail_order() -> void:
	
	globalScript._currentScene._pbar.value -= 5
	
	_ASP2.play()
	
	_idleTimer.wait_time = globalScript._globalRng.randf_range(3.0,15.0)
	_canInteract = false
	_idleTimer.start()

func _succeed_order() -> void:
	_ASP1.play()
	globalScript._currentScene._pbar.value += 3
	
	_idleTimer.wait_time = globalScript._globalRng.randf_range(3.0,15.0)
	_canInteract = false
	_idleTimer.start()

func _interact_with_client() -> void:
	
	var offer : Pickup = globalScript._currentPlayer._recieve_pickup_from_player()
	
	if offer == null:
		_canInteract = true
		return
	else:
		_compare_offering(offer)

func _compare_offering(offer : Pickup):
	
	_clientSprite.visible = false
	_orderSprite.visible = false
	
	if offer._pickupName == _desiredOrder:
		_succeed_order()
	else:
		_fail_order()

func _ready() -> void:
	
	_clientSprite.visible = false
	_orderSprite.visible = false
	
	_idleTimer.wait_time = globalScript._globalRng.randf_range(3.0,10.0)
	
	_idleTimer.start()
	
	_canInteract = false
	_whenInteracted = _interact_with_client
