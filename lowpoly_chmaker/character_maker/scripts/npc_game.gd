extends Spatial

var male_instance = preload("res://character_maker/nodes/chmaker_male.tscn")
var female_instance = preload("res://character_maker/nodes/chmaker_female.tscn")

export var npc_file: String
export var randomize_npc: bool = false
export(String, "standing", "seated", "working", "sleeping") var animation_set: String
export(float, 0, 1, 0.05) var probability = 1

var animation_group: String
var npc_type: String
var npc_description = {}
var npc_id

func _ready():
	if npc_file == "":
		self.queue_free()
	else:
		$Mark.hide()
		npc_load(npc_file)
		$NPCArea.connect("body_entered", self, "npc_area_entered")
		$NPCArea.connect("body_exited", self, "npc_area_exited")

func npc_load(fname: String):
	var ff = File.new()
	var ss = "res://character_maker/data/" + fname + ".npc"
	if ff.open(ss, File.READ) == OK:
		npc_description = ff.get_var()
		npc_type = npc_description.base.key
		_create_npc()
		
		if randomize_npc:
			generate_random_parts()


		else:
			npc_id.set_part(npc_type, npc_description.base.albedo, npc_description.base.roughness, npc_description.base.metalness)

		for i in npc_description:
			if i != "base":
				if randomize_npc and (i == "hair" or i == "eyes" or i == "mouth" or i == "browns" or i == "glasses"):
					pass
				else:
					npc_id.set_part(npc_description[i].key, npc_description[i].albedo, npc_description[i].roughness, npc_description[i].metalness)
		ff.close()
#		npc_id.set_animation(NpcMaker.BODY_PARTS[npc_type].animation_standing[randi()%NpcMaker.BODY_PARTS[npc_type].animation_standing.size()] )
	else:
		self.queue_free()
	npc_id.set_animation(npc_type, "standing")


func _create_npc():
	if npc_type == "male":
		npc_id = male_instance.instance()
	elif npc_type == "female":
		npc_id = female_instance.instance()
	self.add_child(npc_id)


func generate_random_parts():
	var cc = NpcMaker.get_skin_color()
	print("NPCEdit randomize " + npc_type)
	npc_id.set_part(npc_type, cc ,0.0, 0.0)

	var t2 = NpcMaker.BODY_PARTS[npc_type].eyes[randi()%NpcMaker.BODY_PARTS[npc_type].eyes.size()]
	var c2: String = NpcMaker.get_eyes_color()
	npc_id.set_part(t2, c2 ,0.2, 0.0)

	var t3 = NpcMaker.BODY_PARTS[npc_type].mouth[randi()%NpcMaker.BODY_PARTS[npc_type].mouth.size()]
	var c3: String = NpcMaker.get_mouth_color()
	var r3 = 0.1 + (0.3 * randf())
	npc_id.set_part(t3, c3 ,r3, 0.0)

	var t4 = NpcMaker.BODY_PARTS[npc_type].browns[randi()%NpcMaker.BODY_PARTS[npc_type].browns.size()]
	var c4: String = NpcMaker.get_hair_color()
	var r4 = 0.2 + (0.3 * randf())
	npc_id.set_part(t4, c4 ,r4, 0.0)

	var b5: bool = false
	if npc_type == "male":
		if randf() > .2:
			b5 = true
	elif npc_type == "female":
		if randf() > .08:
			b5 = true
	if b5:
		var t5 = NpcMaker.BODY_PARTS[npc_type].hair[randi()%NpcMaker.BODY_PARTS[npc_type].hair.size()]
		npc_id.set_part(t5, c4 ,r4, 0.0)
		npc_description["hair"] = {"key": t5, "albedo": c4, "roughness": r4, "metalness": 0.0}

	var b6: bool = false
	if randf() > .7:
		b6 = true
	if b6:
		var t6: String = NpcMaker.BODY_PARTS[npc_type].glasses[randi()%NpcMaker.BODY_PARTS[npc_type].glasses.size()]
		var c6: Color = Color(randf(), randf(), randf())
		var r6: float = randf()
		var m6: float = randf()
		npc_id.set_part(t6, c6 ,r6, m6)
		npc_description["glasses"] = {"key": t6, "albedo": c6, "roughness": r6, "metalness": m6}



#
# Use these signals to start/end interactions with player
# Remember to configure Collision Mast in NPCArea
#
func npc_area_enter(body):
	NpcMaker.emit_signal("npc_area_entered", self, body)

func npc_area_exit(body):
	NpcMaker.emit_signal("npc_area_exited", self, body)
