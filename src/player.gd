extends CharacterBody2D

@export var gravity: float = 700.0
@export var jump_force: float = -150.0

var is_grav_on := false
var screen_max_y
var is_alive = true

signal player_hit

func _ready() -> void:
	screen_max_y = get_viewport_rect().size.y - 12.0
	
func _physics_process(delta):
	# rotaciona baseado na velocidaded
	self.rotation = deg_to_rad(clamp(self.velocity.y * 0.1, -30, 90))
	
	if is_grav_on:
		self.velocity.y += gravity * delta

		if Input.is_action_just_pressed("jump"):
			self.velocity.y = jump_force

		self.position.y = clamp(self.position.y, 0, screen_max_y)
	
	if self.position.y == screen_max_y and is_alive:
		is_alive = false
		self.take_damage()

	var collision = move_and_collide(velocity * delta)
	if collision:
		emit_signal("player_hit")
		#print("signal emmited!") 

func _play_start() -> void:
	$AnimationPlayer.play("start")

func _play_idle():
	$AnimationPlayer.play("idle")
	
func _play_fall():
	$AnimationPlayer.play("fall")

func take_damage() -> void:
	velocity = Vector2.ZERO
	is_grav_on = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	player_hit.emit()
	_play_fall()
	await $AnimationPlayer.animation_finished
	
	
