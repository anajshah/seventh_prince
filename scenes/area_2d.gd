extends Area2D

var current_body = null
var being_held = false

func _process(_delta):
	if being_held:
		get_parent().global_position = current_body.global_position + Vector2(0, -150)
		#get_parent().global_position = current_body.global_position
		if Input.is_action_just_pressed("ui_accept"):
			being_held = false
			get_parent().global_position.y = -200
			
	elif Input.is_action_just_pressed("ui_accept") and current_body != null:
		being_held = true

func _on_body_entered(body):
	if body.is_in_group("player"):
		current_body = body

func _on_body_exited(body):
	if body == current_body:
		current_body = null
