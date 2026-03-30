extends Node2D

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
var travel_distance : float = 0.0
var is_moving := true

func _process(delta: float) -> void:
	#print(global_position)
	if is_moving:
		position += move_vector * speed * delta
	
		travel_distance += speed * delta
	
	if travel_distance > 600.0:
		queue_free()

func _on_pipes_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.call("take_damage")

func _on_passage_body_entered(body: Node2D) -> void:
	print("score")
