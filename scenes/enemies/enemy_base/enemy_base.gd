class_name EnemyBase
extends CharacterBody2D

@export var gravity: float = 800.0
@export var speed: float = 30.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $WallRay
@onready var floor_ray: RayCast2D = $FloorRay
@onready var hit_area: Area2D = $HitArea
@onready var timer: Timer = $Timer

var _direction: int = -1
var _hit: bool = false

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_update_behavior(delta)
	move_and_slide()

func _apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func _update_behavior(_delta: float) -> void:
	pass

func flip_sprite() -> void:
	animated_sprite_2d.flip_h = _direction == 1

func _flip_raycasts() -> void:
	wall_ray.target_position.x *= -1
	floor_ray.position.x *= -1

func do_walk() -> void:
	if wall_ray.is_colliding() or not floor_ray.is_colliding():
		_direction = -_direction
		flip_sprite()
		_flip_raycasts()
	
	velocity.x = _direction * speed

func _on_stomp_box_stomped() -> void:
	if _hit: return
	_hit = true
	animated_sprite_2d.play("hit")
	set_physics_process.call_deferred(false)
	hit_area.set_monitorable.call_deferred(false)

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "hit":
		queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
