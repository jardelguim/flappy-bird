extends Control

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

func _ready() -> void:
	player.hide()
	get_tree().paused = true
	
func _game_start() -> void:
	player.show()
	player._play_start()
	$TimerLabel/TimerAnimationPlayer.play("timer_animation")
	$GameStartTimer.start()
	$HintTimer.start()

func _on_start_button_pressed() -> void:
	$StartMenu.hide()
	$TimerLabel.show()
	_game_start()
	print("Button pressed")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_game_start_timer_timeout() -> void:
	$HUDBG.hide()
	$TimerLabel.hide()
	get_tree().paused = false

func _on_hint_timer_timeout() -> void:
	$HintLabel.show()
	$HintLabel/HintAnimationPlayer.play("hint_animation")
	await $HintLabel/HintAnimationPlayer.animation_finished
	player.is_grav_on = true


func _on_retry_button_pressed() -> void:
	pass
