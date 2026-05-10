extends Area2D

var current_body = null
var being_held = false

func _process(_delta):
	# 1. HOLDING LOGIC
	if being_held and current_body != null:
		get_parent().global_position = current_body.global_position + Vector2(0, -160)
	
	# 2. PICK UP LOGIC
	if Input.is_action_just_pressed("ui_accept") and current_body != null and not being_held:
		being_held = true
		
	# 3. POISONING LOGIC (The "Release" part)
	elif Input.is_action_just_released("ui_accept") and being_held:
		being_held = false
		check_for_poisoning()

func check_for_poisoning():
	# Look at every Area2D currently touching the poison bottle
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area.name == "meal" or area.is_in_group("meal"):
			# Set the variable on the meal
			area.is_poisoned = true
			
			# Make the poison bottle (the parent) invisible and stop processing
			get_parent().visible = false
			set_process(false) 
			print("Meal is poisoned!")
			return # Exit the function so we don't drop it elsewhere

	# If we didn't find a meal, just drop it at a default height
	get_parent().global_position.y = -260
