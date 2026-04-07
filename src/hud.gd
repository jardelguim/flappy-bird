extends Control

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")
@onready var player_sprite: Control = $StartMenu/PlayerSprite


func _ready() -> void:
	$HUDAnimationPlayer.play("start_fade")

func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed() -> void:
	$HUDAnimationPlayer.play("startmenu_animation")
	await  $HUDAnimationPlayer.animation_finished
	$StartMenu.hide()
	$TimerLabel.show()
	$HintTimer.start()
	$TimerLabel/TimerAnimationPlayer.play("timer_animation")
	$GameStartTimer.start()
	print("Button pressed")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_game_start_timer_timeout() -> void:
	$HUDBG/BGFAde.play("fade_in")
	$TimerLabel.hide()
	$ScoreLabel.show()
	get_tree().paused = false

func _on_hint_timer_timeout() -> void:
	main._start_game()
	$HintLabel.show()
	$HintLabel/HintAnimationPlayer.play("hint_animation")
	await $HintLabel/HintAnimationPlayer.animation_finished
	player.is_grav_on = true

func _on_retry_button_pressed() -> void:
	# $GameOverMenu.hide()
	$HUDAnimationPlayer.play_backwards("game_over_intro")
	$HUDAnimationPlayer.speed_scale = 2.0
	await $HUDAnimationPlayer.animation_finished
	$HUDAnimationPlayer.speed_scale = 1.0
	$ResetTimer.start()
	$TimerLabel.show()
	$TimerLabel/TimerAnimationPlayer.play("timer_animation")
	
func _on_player_hit() -> void:
	$HUDBG.show()
	$HUDAnimationPlayer.play("game_over_intro")
	$HUDBG/BGFAde.play_backwards("fade_in")
	$GameOverMenu/ScoreText.text = "[wave amp=50.0 freq=5.0 connected=1]Score : " + str(main.score) + "[/wave]"
	$GameOverMenu.show()

func _on_reset_timer_timeout() -> void:
	$TimerLabel.hide()
	$HUDBG/BGFAde.play("fade_in")
	main._reset_game()
