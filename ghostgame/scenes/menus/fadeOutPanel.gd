# res://scripts/AutoFadeOutPanel.gd
extends Panel
class_name AutoFadeOutPanel

@export var fade_out_time: float = 1.0
@export var delay_before_fade: float = 0.0
@export var remove_after_fade: bool = true

# === 3 SONIDOS AL INICIO ===
@export var play_sounds_on_start: bool = true
@export var sfx_path_1: String = "res://Assets/sounds/bang.wav"     # Fade out
@export var sfx_path_2: String = "res://Assets/sounds/fire.wav"    # LOOP SIN FADE
@export var sfx_path_3: String = "res://Assets/sounds/titinus.wav" # Fade out

# === CONTROL DE VOLUMEN ===
@export var audio_fade_out: bool = true  # Solo afecta a sonidos 1 y 3
@export var audio_volume_db: float = 0.0

var tween: Tween
var audio_players: Array[AudioStreamPlayer] = []  # Solo sonidos que fadean
var fire_player: AudioStreamPlayer = null        # Sonido 2: NO fadea

func _ready() -> void:
	modulate.a = 1.0
	
	# === REPRODUCIR LOS 3 SONIDOS ===
	if play_sounds_on_start:
		_play_sfx(sfx_path_1)           # Normal + fade
		_play_looping_sfx_no_fade(sfx_path_2)  # LOOP SIN FADE
		_play_sfx(sfx_path_3)           # Normal + fade
	
	# Iniciar fade out del panel
	if delay_before_fade > 0.0:
		await get_tree().create_timer(delay_before_fade).timeout
	_start_fade_out()

func _start_fade_out() -> void:
	_kill_tween()
	tween = create_tween()
	
	# Fade del panel
	tween.parallel().tween_property(self, "modulate:a", 0.0, fade_out_time)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	
	# FADE OUT SOLO DE SONIDOS 1 Y 3
	if audio_fade_out:
		for player in audio_players:
			if is_instance_valid(player):
				tween.parallel().tween_property(player, "volume_db", -80.0, fade_out_time)\
					.set_trans(Tween.TRANS_LINEAR)
	
	# SONIDO 2 NO FADEA → se queda sonando
	tween.finished.connect(_on_fade_complete)

func _on_fade_complete() -> void:
	if remove_after_fade:
		queue_free()  # fire_player sigue vivo en el árbol

func _kill_tween() -> void:
	if tween and is_instance_valid(tween):
		tween.kill()
		tween = null

# === SONIDO NORMAL (fade out) ===
func _play_sfx(path: String) -> void:
	if path == "" or not (path.ends_with(".wav") or path.ends_with(".ogg") or path.ends_with(".mp3")):
		return
	
	var stream = load(path) as AudioStream
	if not stream:
		push_error("No se pudo cargar: ", path)
		return
	
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = audio_volume_db
	player.autoplay = true
	add_child(player)
	audio_players.append(player)
	
	player.finished.connect(player.queue_free)

# === SONIDO 2: LOOP INFINITO + NO FADE OUT ===
func _play_looping_sfx_no_fade(path: String) -> void:
	if path == "" or not (path.ends_with(".wav") or path.ends_with(".ogg") or path.ends_with(".mp3")):
		return
	
	var stream = load(path) as AudioStream
	if not stream:
		push_error("No se pudo cargar LOOP: ", path)
		return
	
	fire_player = AudioStreamPlayer.new()
	fire_player.stream = stream
	fire_player.volume_db = audio_volume_db
	fire_player.autoplay = true
	fire_player.process_mode = Node.PROCESS_MODE_ALWAYS  # Sigue vivo al cambiar escena
	add_child(fire_player)
	
	# LOOP INFINITO
	fire_player.finished.connect(func():
		if is_instance_valid(fire_player):
			fire_player.play()
	)
	
	fire_player.play()
