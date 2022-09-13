extends HSlider

export var item_type: String

func _ready():
	self.connect("value_changed", self, "change_roughness")


func change_roughness(value: float):
	NpcMaker.emit_signal("set_roughness", item_type, value)
