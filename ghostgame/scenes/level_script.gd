extends Node2D

@export var _pbar : TextureProgressBar

func _physics_process(delta: float) -> void:
	_pbar.value -= 0.02
	
	if _pbar.value <= 0:
		
		print("game over!")
		
		self.process_mode = Node.PROCESS_MODE_DISABLED
