extends NinePatchRect

@onready var label = $Label

var dialog_lines = [
	"Hi! My name is [undecided] and I'm part 
	of the royal family",
	"But unfortunately I am the youngest son
	 so the throne will not be left to me",
	"It is now our goal to poison my elder 
	brother so I can be next in line",
	"Look for the poison and put it in his 
	food",
	"But make sure the gaurds don't catch 
	you holding poison or its off with our 
	head!"
]
var current_line = 0
var is_typing = false

func _ready():
	self.show()
	self.modulate.a = 1.0
	display_line()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			label.visible_ratio = 1.0
			is_typing = false
		else:
			current_line += 1
			if current_line < dialog_lines.size():
				display_line()
			else:
				queue_free()

func display_line():
	label.text = dialog_lines[current_line]
	label.visible_ratio = 0.0
	is_typing = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 2.0)
	tween.finished.connect(func(): is_typing = false)
