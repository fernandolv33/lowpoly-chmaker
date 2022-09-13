extends Spatial


func _ready():
	$Character/NPCEdit.create_npc("male")
#	NpcMaker.connect("set_color", self, "set_color")


func _on_new_npc_pressed(type_npc):
	if type_npc == 1:
		$Character/NPCEdit.create_npc("male")
	elif type_npc == 2:
		$Character/NPCEdit.create_npc("female")

func _on_Randomize_pressed():
	$Character/NPCEdit.randomize_npc()


func _on_Save_pressed():
	if $CanvasLayer/C/HB/LeftControl/M/V/File/FileName.text != "":
		NpcMaker.emit_signal("npc_save", $CanvasLayer/C/HB/LeftControl/M/V/File/FileName.text)

func _on_Load_pressed():
	if $CanvasLayer/C/HB/LeftControl/M/V/File/FileName.text != "":
		NpcMaker.emit_signal("npc_load", $CanvasLayer/C/HB/LeftControl/M/V/File/FileName.text)
