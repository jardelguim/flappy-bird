extends Node
class_name ButtonEffectsModule

@export var ease_type : Tween.EaseType
@export var trans_type : Tween.TransitionType
@export var anim_duration : float = 0.07
@export var scale_amount : Vector2 = Vector2(1.1 , 1.1)
@export var rotation_amount : float = 3.0

@onready var button : Button = get_parent()

func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_hovered.bind(true))
	button.mouse_exited.connect(_on_mouse_hovered.bind(false))
	
func _on_mouse_hovered() -> void:
	pass
	
