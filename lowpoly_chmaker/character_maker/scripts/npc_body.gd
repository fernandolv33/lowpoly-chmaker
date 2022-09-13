extends Spatial

onready var skeleton_node = find_node("Skeleton")

var npc_type: String
var animation_group: String

func _ready():
	for i in skeleton_node.get_children():
		var mesh = i.mesh.duplicate()
		i.mesh = mesh
		var material = i.mesh.surface_get_material(0).duplicate()
		i.mesh.surface_set_material(0, material)
		if i.name == "male" or i.name == "female":
			pass
		else:
			i.hide()
	$AnimationPlayer.connect("animation_finished", self, "animation_loop")


func init_npc():
	pass


func set_npc():
	pass


func set_part(part: String, p_color: Color, p_rgh: float, p_met: float):
	var inode = skeleton_node.find_node(part)
	if inode:
		var material = inode.mesh.surface_get_material(0).duplicate()
		inode.mesh.surface_set_material(0, material)
		material.albedo_color = p_color
		material.roughness = p_rgh
		material.metallic = p_met
		inode.show()


func hide_part(part: String):
	var inode = skeleton_node.find_node(part)
	if inode:
		inode.hide()


func set_animation(tt:String, aa: String):
	npc_type = tt
	animation_group = aa
	var animation = NpcMaker.get_animation(npc_type, animation_group)
	$AnimationPlayer.play(animation)


func animation_loop(anim: String):
	if animation_group == "sleep":
		$AnimationPlayer.stop()
	var animation = NpcMaker.get_animation(npc_type, animation_group)
	$AnimationPlayer.play(animation)
	
