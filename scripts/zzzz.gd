extends Node2D

@export var speed := 250.0

var direction := Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta
