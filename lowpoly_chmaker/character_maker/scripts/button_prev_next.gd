extends Button

export var item_type: String
export var previous: bool = false


func _ready():
	self.connect("pressed", self, "select_next")



func select_next():
	var aa: int
	if previous:
		aa = -1
	else:
		aa = 1
	
	NpcMaker.emit_signal("next_item", item_type, aa)
