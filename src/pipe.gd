extends Area2D

enum Direction {
	LEFT,
	RIGHT
}

const DIRECTION_VECTORS = {
	Direction.LEFT : Vector2( -1 , 0),
	Direction.RIGHT : Vector2( 1 , 0),
}

@export var direction_vector : Direction = Direction.LEFT
@export var speed : float = 10.0

var move_vector : Vector2 = DIRECTION_VECTORS[direction_vector]


func _process(delta: float) -> void:
	#print(global_position)
	position += move_vector * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.call("take_damage")
