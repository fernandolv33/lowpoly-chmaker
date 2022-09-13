extends CheckBox

export var item_type: String
export var item_number: int


func _on_button_switch_toggled(button_pressed):
	if button_pressed:
		NpcMaker.emit_signal("direct_add_item", item_type, item_number, "f6f6f6", 0.0, 0.7)
	else:
		NpcMaker.emit_signal("direct_remove_item", item_type, item_number)
