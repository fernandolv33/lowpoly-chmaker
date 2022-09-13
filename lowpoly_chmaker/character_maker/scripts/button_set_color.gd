extends Button

export var item_type: String
export var my_color: Color

func _ready():
	self.connect("pressed", self, "change_color")


func change_color():
	NpcMaker.emit_signal("set_color", item_type, my_color)

