extends Label

func _ready():
	connect("gui_input",Edit)
	

func Edit(event:InputEvent):
	if event.is_action_pressed("L_Click"):
		add_sibling(self.duplicate())
		
