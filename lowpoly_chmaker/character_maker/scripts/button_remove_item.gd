extends Button

export var item_type: String


func _ready():
	self.connect("pressed", self, "remove")
	
	
func remove():
	print("Button...")
	NpcMaker.emit_signal("remove_item", item_type)
