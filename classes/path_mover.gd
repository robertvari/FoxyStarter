@tool
extends PathFollow2D

@export var speed: float = 50.0
@export var ping_pong: bool = true

var _direction: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop = !ping_pong


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		progress += speed * delta * _direction
	
	if !ping_pong: return
	
	if progress_ratio > 0.99 and _direction == 1:
		_direction = -1
	if progress_ratio < 0.01 and _direction == -1:
		_direction = 1
