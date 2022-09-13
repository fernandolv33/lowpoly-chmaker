extends Spatial

const node_root: String = "Armature_female/Skeleton/"
const body_node: String = "type_1"
const item_path: String = "Armature_female/Skeleton/female_"

const BROWNS: int = 4
const EYES: int = 4
const MOUTHS: int = 2
const HAIRS: int = 0
const FACIAL_HAIRS: int = 0
const MASKS: int = 0
const OVERALLS: int = 0
const PANTS: int = 0
const SHIRTS: int = 0
const OTHERS: int = 0
const SHOES: int = 0


func _ready():
	hide_all()
	pass


func hide_all():
	for i in $Armature_female/Skeleton.get_children():
		i.hide()
	$Armature_female/Skeleton/female_type_1.show()

	print(get_node(item_path + body_node))



func load_npc(npc_file: String):
	print (npc_file)

func save_npc(npc_file: String):
	print (npc_file)

