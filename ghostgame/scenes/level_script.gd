extends Node2D

@export var _pbar : TextureProgressBar
@export var _timeLVLtext : Label
@export var _timer : Timer

func _ready() -> void:
	$AudioStreamPlayer.play()

func _physics_process(delta: float) -> void:
	_pbar.value -= 0.02
	
	_timeLVLtext.text = str(int(_timer.time_left)) 
	
	if _pbar.value <= 0:
		
		print("game over!")
		
		self.process_mode = Node.PROCESS_MODE_DISABLED
