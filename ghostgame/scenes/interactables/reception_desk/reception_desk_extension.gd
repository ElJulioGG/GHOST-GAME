extends Interactable

@export_category("Reception Desk")
@export var _orderTimer : Timer
@export var _idleTimer : Timer
@export var _possibleOrders : Array[String]
@export var _orderWeights : Array[float]
var _desiredOrder : String

func _on_idle_timer_timeout() -> void:
	print("idle stopped, picking...")
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
			return 
	
	#failsafe
	_desiredOrder = _possibleOrders[0]
	_canInteract = true
	_orderTimer.start()
	return

func _on_order_timer_timeout() -> void:
	print("order missed")
	_fail_order()

func _fail_order() -> void:
	
	# fail conditions go here
	print("order failed! idling...")
	
	_canInteract = false
	_idleTimer.start()

func _succeed_order() -> void:
	# fail conditions go here
	print("order is good! idling...")
	
	_canInteract = false
	_idleTimer.start()

func _interact_with_client() -> void:
	
	var offer : Pickup = globalScript._currentPlayer._recieve_pickup_from_player()
	
	if offer == null:
		print("nothing to offer...")
		_canInteract = true
		return
	else:
		_compare_offering(offer)

func _compare_offering(offer : Pickup):
	if offer._pickupName == _desiredOrder:
		_succeed_order()
	else:
		_fail_order()

func _ready() -> void:
	_canInteract = false
	_whenInteracted = _interact_with_client
