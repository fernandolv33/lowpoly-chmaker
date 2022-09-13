extends Spatial

var npc_type: String
var npc_description = {}
var npc_id

var male_instance = preload("res://character_maker/nodes/chmaker_male.tscn")
var female_instance = preload("res://character_maker/nodes/chmaker_female.tscn")



func _ready():
	NpcMaker.connect("set_color", self, "set_color")
	NpcMaker.connect("set_roughness", self, "set_roughness")
	NpcMaker.connect("set_metalness", self, "set_metalness")
	NpcMaker.connect("next_item", self, "next_item")
	NpcMaker.connect("remove_item", self, "remove_item")

	NpcMaker.connect("direct_add_item", self, "direct_add_item")
	NpcMaker.connect("direct_remove_item", self, "direct_remove_item")

	NpcMaker.connect("npc_load", self, "npc_load")
	NpcMaker.connect("npc_save", self, "npc_save")



func clear_npc():
	npc_description.clear()
	for i in self.get_children():
		i.queue_free()


func create_npc(tt: String):
	clear_npc()
	npc_type = tt
	_create_npc()
	randomize_npc()


func _create_npc():
	if npc_type == "male":
		npc_id = male_instance.instance()
	elif npc_type == "female":
		npc_id = female_instance.instance()
	self.add_child(npc_id)


func randomize_npc():
	npc_description.clear()
	
	var style = NpcMaker.STYLES[randi()%NpcMaker.STYLES.size()]
	
	var cc = NpcMaker.get_skin_color()
	npc_id.set_part(npc_type, cc ,0.0, 0.0)
	npc_description["base"] = {"key": npc_type, "albedo": cc, "roughness": 0.0, "metalness": 0.0}

# Eyes
	var t2 = NpcMaker.BODY_PARTS[npc_type].eyes[randi()%NpcMaker.BODY_PARTS[npc_type].eyes.size()]
	var c2: String = NpcMaker.get_eyes_color()
	npc_id.set_part(t2, c2 ,0.2, 0.0)
	npc_description["eyes"] = {"key": t2, "albedo": c2, "roughness": 0.2, "metalness": 0.0}

# Mouth
	var t3 = NpcMaker.BODY_PARTS[npc_type].mouth[randi()%NpcMaker.BODY_PARTS[npc_type].mouth.size()]
	var c3: String = NpcMaker.get_mouth_color()
	var r3 = 0.1 + (0.3 * randf())
	npc_id.set_part(t3, c3 ,r3, 0.0)
	npc_description["mouth"] = {"key": t3, "albedo": c3, "roughness": r3, "metalness": 0.0}


# browns
	var t4 = NpcMaker.BODY_PARTS[npc_type].browns[randi()%NpcMaker.BODY_PARTS[npc_type].browns.size()]
	var c4: String = NpcMaker.get_hair_color()
	var r4 = 0.2 + (0.3 * randf())
	npc_id.set_part(t4, c4 ,r4, 0.0)
	npc_description["browns"] = {"key": t4, "albedo": c4, "roughness": r4, "metalness": 0.0}

	# hair
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

	# glasses
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

	# shoes
	var t7: String = NpcMaker.BODY_PARTS[npc_type].shoes[randi()%NpcMaker.BODY_PARTS[npc_type].shoes.size()]
#	var c7: Color = NpcMaker.SHOES_COLOR[randi()%NpcMaker.SHOES_COLOR.size()]
	var c7: Color = NpcMaker.get_color_by_style(style)

	var r7: float = randf()
	var m7: float = randf()


	npc_id.set_part(t7, c7 ,r7, m7)
	npc_description["shoes"] = {"key": t7, "albedo": c7, "roughness": r7, "metalness": m7}

	# jacket or belt
	if randf() > 0.5:
		var t15: String = NpcMaker.BODY_PARTS[npc_type].jacket[randi()%NpcMaker.BODY_PARTS[npc_type].jacket.size()]
		var c15: Color = NpcMaker.get_color_by_style(style)
		var r15: float = randf()
		var m15: float = 0.3*randf()
		npc_id.set_part(t15, c15 ,r15, m15)
		npc_description["jacket"] = {"key": t15, "albedo": c15, "roughness": r15, "metalness": m15}
	else:
		if randf() > 0.4:
			var t8: String = NpcMaker.BODY_PARTS[npc_type].belt[randi()%NpcMaker.BODY_PARTS[npc_type].belt.size()]
			var c8: Color = NpcMaker.get_color_by_style(style)
			var r8: float = randf()
			npc_id.set_part(t8, c8 ,r8, 0.0)
			npc_description["belt"] = {"key": t8, "albedo": c8, "roughness": r8, "metalness": 0.0}

	# clothes
	if randf() > .6:
		var t10: String = NpcMaker.BODY_PARTS[npc_type].bodysuit[randi()%NpcMaker.BODY_PARTS[npc_type].bodysuit.size()]
		var c10: Color = NpcMaker.get_color_by_style(style)
		var r10: float = randf()
		var m10: float = 0.3*randf()
		npc_id.set_part(t10, c10 ,r10, m10)
		npc_description["bodysuit"] = {"key": t10, "albedo": c10, "roughness": r10, "metalness": m10}

	else:
		var t11: String = NpcMaker.BODY_PARTS[npc_type].shirt[randi()%NpcMaker.BODY_PARTS[npc_type].shirt.size()]
		var t12: String = NpcMaker.BODY_PARTS[npc_type].pants[randi()%NpcMaker.BODY_PARTS[npc_type].pants.size()]

		var r11: float = randf()
		var r12: float = randf()
		var m11: float = 0.3*randf()
		var m12: float = 0.3*randf()
		var c11: Color = NpcMaker.get_color_by_style(style)
		var c12: Color = NpcMaker.get_color_by_style(style)
		npc_id.set_part(t11, c11 ,r11, m11)
		npc_id.set_part(t12, c12 ,r12, m12)
		npc_description["shirt"] = {"key": t11, "albedo": c11, "roughness": r11, "metalness": m11}
		npc_description["pants"] = {"key": t12, "albedo": c12, "roughness": r12, "metalness": m12}

# amination
	if randf()>0.3:
		npc_id.set_animation(npc_type, "standing")
	else:
		npc_id.set_animation(npc_type, "working")
#	npc_id.set_animation(npc_type, "standing")
#	npc_id.set_animation(npc_type, "seated")
#	npc_id.set_animation(npc_type, "working")
#	npc_id.set_animation(npc_type, "sleeping")






func npc_load(fname: String):
	var ff = File.new()
	var ss = "res://character_maker/data/" + fname + ".npc"
	if ff.open(ss, File.READ) == OK:
		clear_npc()
		npc_description = ff.get_var()
		npc_type = npc_description.base.key
		_create_npc()
		npc_id.set_part(npc_type, npc_description.base.albedo, npc_description.base.roughness, npc_description.base.metalness)
		for i in npc_description:
			if i != "base":
				npc_id.set_part(npc_description[i].key, npc_description[i].albedo, npc_description[i].roughness, npc_description[i].metalness)
		ff.close()

		if randf()>0.3:
			npc_id.set_animation(npc_type, "standing")
		else:
			npc_id.set_animation(npc_type, "working")

#		npc_id.set_animation(npc_type, animation_set)

#	npc_id.set_animation(NpcMaker.BODY_PARTS[npc_type].animation_standing[randi()%NpcMaker.BODY_PARTS[npc_type].animation_standing.size()] )


func npc_save(fname: String):
	var ff = File.new()
	var ss = "res://character_maker/data/" + fname + ".npc"
	ff.open(ss, File.WRITE)
	ff.store_var(npc_description)
	ff.close()


func set_color(item_type: String, new_color: Color):
	if npc_description.has(item_type):
		npc_description[item_type].albedo = new_color
		npc_id.set_part(npc_description[item_type].key, npc_description[item_type].albedo, npc_description[item_type].roughness, npc_description[item_type].metalness)


func set_roughness(item_type: String, new_roughness: float):
	if npc_description.has(item_type):
		npc_description[item_type].roughness = new_roughness
		npc_id.set_part(npc_description[item_type].key, npc_description[item_type].albedo, npc_description[item_type].roughness, npc_description[item_type].metalness)


func set_metalness(item_type: String, new_metalness: float):
	if npc_description.has(item_type):
		npc_description[item_type].metalness = new_metalness
		npc_id.set_part(npc_description[item_type].key, npc_description[item_type].albedo, npc_description[item_type].roughness, npc_description[item_type].metalness)


func next_item(item_type: String, displacement: int):
	if npc_description.has(item_type):
		var actual_pos: int = NpcMaker.BODY_PARTS[npc_type][item_type].find(npc_description[item_type].key)
		var item_to_delete: String = npc_description[item_type].key
		var new_position: int = actual_pos + displacement
		if new_position < 0:
			new_position = NpcMaker.BODY_PARTS[npc_type][item_type].size() - 1
		if new_position >= NpcMaker.BODY_PARTS[npc_type][item_type].size():
			new_position = 0
		var item_to_add: String = NpcMaker.BODY_PARTS[npc_type][item_type][new_position]
		
		npc_id.hide_part(item_to_delete)

		npc_description[item_type].key = item_to_add
		npc_id.set_part(item_to_add, npc_description[item_type].albedo, npc_description[item_type].roughness, npc_description[item_type].metalness)
	else:
		if NpcMaker.BODY_PARTS[npc_type].has(item_type):
			if NpcMaker.BODY_PARTS[npc_type][item_type].size() > 0:
				npc_description[item_type] = {"key": NpcMaker.BODY_PARTS[npc_type][item_type][0], "albedo": "000000", "roughness": 1.0, "metalness": 0.0 }
				npc_id.set_part(npc_description[item_type].key, npc_description[item_type].albedo, npc_description[item_type].roughness, npc_description[item_type].metalness)


func remove_item(item_type):
	if npc_description.has(item_type):
		var item_to_delete: String = npc_description[item_type].key
		npc_id.hide_part(item_to_delete)
		npc_description.erase(item_type)


func direct_add_item(item_type: String, item_number: int, cc: Color, rr: float, mm: float):
	if not npc_description.has(NpcMaker.BODY_PARTS[npc_type][item_type]):
#		print(NpcMaker.BODY_PARTS[npc_type][item_type])
		npc_description[NpcMaker.BODY_PARTS[npc_type][item_type][item_number]] = {"key": NpcMaker.BODY_PARTS[npc_type][item_type][item_number], "albedo": cc, "roughness": rr, "metalness": mm }
		npc_id.set_part(NpcMaker.BODY_PARTS[npc_type][item_type][item_number], cc, rr, mm)


func direct_remove_item(item_type: String, item_number: int):
	if npc_description.has(NpcMaker.BODY_PARTS[npc_type][item_type][item_number]):
		npc_id.hide_part(NpcMaker.BODY_PARTS[npc_type][item_type][item_number])
		npc_description.erase(NpcMaker.BODY_PARTS[npc_type][item_type][item_number])

