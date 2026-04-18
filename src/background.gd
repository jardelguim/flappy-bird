extends Node2D

@onready var clouds: Parallax2D = $Clouds
@onready var forest: Parallax2D = $Forest

@export var scroll_speed : float = 1

func _process(_delta: float) -> void:
	_scroll_background()

func _scroll_background():
	clouds.screen_offset.x = lerp(clouds.screen_offset.x , clouds.screen_offset.x + 0.5 , 0.5)
	forest.screen_offset.x = lerp(forest.screen_offset.x , forest.screen_offset.x + 0.5 , 1)
	
