extends HSlider

export var item_type: String

func _ready():
	self.connect("value_changed", self, "change_metalness")


func change_metalness(value: float):
	NpcMaker.emit_signal("set_metalness", item_type, value)
