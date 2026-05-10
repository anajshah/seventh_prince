extends Area2D

var current_body = null  
var being_held = false

func _process(_delta):
	if being_held and current_body != null:
		get_parent().global_position = current_body.global_position + Vector2(0, -160)
		
	if Input.is_action_just_pressed("ui_accept") and current_body != null and not being_held:
		being_held = true
		check_guard_collision()

	elif Input.is_action_just_released("ui_accept") and being_held:
		var areas = get_overlapping_areas()
		for area in areas:
			if area.is_in_group("meal"):
				Global.meal_is_poisoned = true 
				print("meal poisoned")
				get_tree().change_scene_to_file("res://scenes/win.tscn")
				get_parent().visible = false
				being_held = false
				set_process(false)
				return
		being_held = false
		get_parent().global_position.y = -260

func check_guard_collision():
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("gaurd") and being_held:
			get_tree().change_scene_to_file("res://scenes/caught.tscn")

func _on_area_entered(area):
	if area.is_in_group("gaurd") and being_held:
		get_tree().change_scene_to_file("res://scenes/caught.tscn")

func _on_body_entered(body):
	if body.is_in_group("player"):
		current_body = body

func _on_body_exited(body):
	if body == current_body:
		current_body = null

#var current_body = null
#var being_held = false

#func _process(_delta):
#	if being_held:
#		get_parent().global_position = current_body.global_position + Vector2(0, -160)
#		#get_parent().global_position = current_body.global_position
#		if Input.is_action_just_pressed("ui_accept"):
#			being_held = false
#			get_parent().global_position.y = -260
			
#	elif Input.is_action_just_pressed("ui_accept") and current_body != null:
#		being_held = true

#func _on_body_entered(body):
#	if body.is_in_group("player"):
#		current_body = body

#func _on_body_exited(body):
#	if body == current_body:
#		current_body = null
#
