extends Node

var sound_mapper = {
	"die": "res://assets/sounds/sfx_die.wav",
	"hit": "res://assets/sounds/sfx_hit.wav",
	"point": "res://assets/sounds/sfx_point.wav",
	"wing": "res://assets/sounds/sfx_wing.wav",
	"confirm": "res://assets/sounds/menu confirm.wav",
	"select": "res://assets/sounds/menu select.wav",
	"ambient": "res://assets/sounds/ambient_white_dryforest.mp3"
}
var char_audio_player = AudioStreamPlayer.new()
var effect_audio_player = AudioStreamPlayer.new()
var music_audio_player = AudioStreamPlayer.new()
enum PlayerOpts { char, effect , music }

func _ready() -> void:
	get_tree().get_root().get_node("/root/Sound").add_child(char_audio_player)
	get_tree().get_root().get_node("/root/Sound").add_child(effect_audio_player)
	get_tree().get_root().get_node("/root/Sound").add_child(music_audio_player)
	music_audio_player.volume_db = -10
	char_audio_player.volume_db = -5
	effect_audio_player.volume_db = -5
	process_mode = Node.PROCESS_MODE_ALWAYS

func play_sound(sound_id: String, player: String = "char"):
	var audio_stream = load(sound_mapper[sound_id])
	var audio_player
	match player:
		"char":
			audio_player = char_audio_player
		"effect":
			audio_player = effect_audio_player
		"music":
			audio_player = music_audio_player
	audio_player.stream = audio_stream
	audio_player.play()

func stop_sound():
	char_audio_player.stop()
	effect_audio_player.stop()
