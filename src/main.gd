extends Node2D

const PIPE = preload("res://scenes/pipe.tscn")

func _ready() -> void:
	_spawn_pipe($%SpawnPoint.global_position)
	
func _spawn_pipe(pos) -> void:
	var new_pipe = PIPE.instantiate()
	new_pipe.global_position = pos
	add_child(new_pipe)

func _on_timer_timeout() -> void:
	_spawn_pipe($%SpawnPoint.global_position)
