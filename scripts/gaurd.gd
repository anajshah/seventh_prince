extends Area2D

@export var speed: float = 200.0

func _process(delta):
	position += Vector2.LEFT * speed * delta
