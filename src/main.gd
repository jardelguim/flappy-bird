extends Node2D

var score = 0
var player_start_pos : Vector2 = Vector2.ZERO

const PIPE = preload("res://scenes/pipe.tscn")

@onready var player: CharacterBody2D = $Player
@onready var playeranim : AnimationPlayer = $Player/AnimationPlayer
@onready var parallax_bg: Node2D = $ParallaxBG


func _ready() -> void:
	#player.hide()
	player_start_pos = player.global_position
	get_tree().paused = true

func _reset_pipes() -> void:
	player.global_position = player_start_pos
	#player._play_idle()
	#player.process_mode = Node.PROCESS_MODE_INHERIT
	for pipe in $Pipes.get_children():
		pipe.queue_free()
		score = 0

func _reset_game() -> void:
	_reset_pipes()
	player._play_start()
	get_tree().paused = false
	score = 0
	$HUDLayer/HUD.update_score(0)
	await playeranim.animation_finished
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.is_alive = true
	player.is_grav_on = true

func _start_game() -> void:
	player.show()
	player._play_start()

func _spawn_pipe(pos) -> void:
	var new_pipe = PIPE.instantiate()
	new_pipe.global_position.x = pos.x
	new_pipe.global_position.y = randf_range(49 , 140)
	new_pipe.pipe_passed.connect(_increase_score)
	$Pipes.add_child(new_pipe)

func _on_pipe_timer_timeout() -> void:
	_spawn_pipe($%SpawnPoint.global_position)

func _on_player_hit() -> void:  
	print(parallax_bg.process_mode)
	parallax_bg.process_mode = Node.PROCESS_MODE_INHERIT

func _increase_score() -> void:
	Sound.play_sound("point", "effect")
	score += 1
	$HUDLayer/HUD.update_score(score)
