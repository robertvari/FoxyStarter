extends EnemyBase

enum ChickenState {WALK, JUMP}

var _state: ChickenState = ChickenState.WALK

@export var jump_force: float = -250.0
@export var jump_lifetime: float = 3.0
@export var walk_duration: float = 1.5
@export var gravity_curve: Curve

var _in_air: float = 0.0
var _gravity_mult: float = 1.0

func _ready() -> void:	
	change_state(ChickenState.WALK)

func _apply_gravity(delta: float) -> void:
	if _state == ChickenState.JUMP and gravity_curve:
		var t: float = clampf(_in_air / jump_lifetime, 0.0, 1.0)
		_gravity_mult = gravity_curve.sample(t)
	velocity.y += gravity * delta *_gravity_mult

func _update_behavior(delta: float) -> void:
	match _state:
		ChickenState.WALK:
			do_walk()
		ChickenState.JUMP:
			_in_air += delta
			if is_on_floor() and velocity.y >= 0:
				change_state(ChickenState.WALK)

func change_state(new_state: ChickenState) -> void:
	if _hit: return
	_state = new_state
	_gravity_mult = 1.0
	match _state:
		ChickenState.WALK:
			animated_sprite_2d.play("walk")
			timer.start(walk_duration)
		ChickenState.JUMP:
			_in_air = 0.0
			velocity.y = jump_force
			animated_sprite_2d.play("jump")

func _on_timer_timeout() -> void:
	change_state(ChickenState.JUMP)
