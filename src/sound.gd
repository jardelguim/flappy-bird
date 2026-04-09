extends Node

var sound_mapper = {
	"die": "res://assets/sounds/sfx_die.wav",
	"hit": "res://assets/sounds/sfx_hit.wav",
	"point": "res://assets/sounds/sfx_point.wav",
	"swooshing": "res://assets/sounds/sfx_swooshing.wav",
	"wing": "res://assets/sounds/sfx_wing.wav"
}
var char_audio_player = AudioStreamPlayer.new()
var effect_audio_player = AudioStreamPlayer.new()
enum PlayerOpts { char, effect }

func _ready() -> void:
	get_tree().get_root().get_node("/root/Sound").add_child(char_audio_player)
	get_tree().get_root().get_node("/root/Sound").add_child(effect_audio_player)


func play_sound(sound_id: String, player: String = "char"):
	var audio_stream = load(sound_mapper[sound_id])
	var audio_player = char_audio_player if player == "char" else  effect_audio_player
	audio_player.stream = audio_stream
	audio_player.play()
