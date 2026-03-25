extends CharacterBody2D

@export var gravity: float = 800.0
@export var jump_force: float = -300.0

func _physics_process(delta):
	# rotaciona baseado na velocidaded
	self.rotation = deg_to_rad(clamp(self.velocity.y * 0.1, -30, 90))
	self.velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		self.velocity.y = jump_force

	var collision = move_and_collide(velocity * delta)
	if collision:
		die()

func die():
	# Emitir o sinal de morte e deixar outro se virar para dar game over
	queue_free()
