extends Node

signal spawn_scene(pos: Vector2, scene: PackedScene)
signal spawn_bullet(velocity: Vector2, start_pos: Vector2, scene: PackedScene)


func emit_spawn_scene(pos: Vector2, scene: PackedScene) -> void:
	spawn_scene.emit(pos, scene)

func emit_spawn_pullet(velocity: Vector2, start_pos: Vector2, scene: PackedScene) -> void:
	spawn_bullet.emit(velocity, start_pos, scene)
