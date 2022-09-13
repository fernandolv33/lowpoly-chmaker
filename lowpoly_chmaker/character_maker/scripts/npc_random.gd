extends Spatial

var male_instance = preload("res://character_maker/nodes/chmaker_male.tscn")
var female_instance = preload("res://character_maker/nodes/chmaker_female.tscn")

export(float, 0, 1, 0.05) var probability = 0.7
export(float, 0, 1, 0.05) var npc_sex = 0.5

export var style_DARK: bool = true
export var style_EVIL: bool = true
export var style_PEACE: bool = true
export var style_EARTH: bool = true
export var style_FIRE: bool = true
export var style_NAVAL: bool = true
export var style_LIGHT: bool = true

export(String, "standing", "seated", "working", "sleeping") var animation_set: String = "standing"


var npc_type: String
var animation_group: String
var npc_id
var npc_styles = []

func _ready():
	var count_styles: int = 0

	$Mark.hide()
	if randf() > probability:
		self.queue_free()
		return

	$NPCArea.connect("body_entered", self, "npc_area_entered")
	$NPCArea.connect("body_exited", self, "npc_area_exited")

	if style_DARK:
		npc_styles.append("DARK")
		count_styles += 1
	if style_EVIL:
		npc_styles.append("EVIL")
		count_styles += 1
	if style_PEACE:
		npc_styles.append("PEACE")
		count_styles += 1
	if style_EARTH:
		npc_styles.append("EARTH")
		count_styles += 1
	if style_FIRE:
		npc_styles.append("FIRE")
		count_styles += 1
	if style_NAVAL:
		npc_styles.append("NAVAL")
		count_styles += 1
	if style_LIGHT:
		npc_styles.append("LIGHT")
		count_styles += 1

	if count_styles < 1:
		self.queue_free()

	create_npc()
	generate_random_parts()


func create_npc():
	if npc_sex > randf():
		npc_type = "male"
		npc_id = male_instance.instance()
	else:
		npc_type = "female"
		npc_id = female_instance.instance()
	self.add_child(npc_id)


func generate_random_parts():
	var style = NpcMaker.STYLES[randi()%NpcMaker.STYLES.size()]
	
	var cc = NpcMaker.get_skin_color()
	npc_id.set_part(npc_type, cc ,0.0, 0.0)

# Eyes
	var t2 = NpcMaker.BODY_PARTS[npc_type].eyes[randi()%NpcMaker.BODY_PARTS[npc_type].eyes.size()]
	var c2: String = NpcMaker.get_eyes_color()
	npc_id.set_part(t2, c2 ,0.2, 0.0)

# Mouth
	var t3 = NpcMaker.BODY_PARTS[npc_type].mouth[randi()%NpcMaker.BODY_PARTS[npc_type].mouth.size()]
	var c3: String = NpcMaker.get_mouth_color()
	var r3 = 0.1 + (0.3 * randf())
	npc_id.set_part(t3, c3 ,r3, 0.0)


# browns
	var t4 = NpcMaker.BODY_PARTS[npc_type].browns[randi()%NpcMaker.BODY_PARTS[npc_type].browns.size()]
	var c4: String = NpcMaker.get_hair_color()
	var r4 = 0.2 + (0.3 * randf())
	npc_id.set_part(t4, c4 ,r4, 0.0)

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

	# shoes
	var t7: String = NpcMaker.BODY_PARTS[npc_type].shoes[randi()%NpcMaker.BODY_PARTS[npc_type].shoes.size()]
#	var c7: Color = NpcMaker.SHOES_COLOR[randi()%NpcMaker.SHOES_COLOR.size()]
	var c7: Color = NpcMaker.get_color_by_style(style)

	var r7: float = randf()
	var m7: float = randf()
	npc_id.set_part(t7, c7 ,r7, m7)

	# jacket or belt

	if randf() > 0.5:
		var t15: String = NpcMaker.BODY_PARTS[npc_type].jacket[randi()%NpcMaker.BODY_PARTS[npc_type].jacket.size()]
		var c15: Color = NpcMaker.get_color_by_style(style)
		var r15: float = randf()
		var m15: float = 0.3*randf()
		npc_id.set_part(t15, c15 ,r15, m15)
	else:
		if randf() > 0.4:
			var t8: String = NpcMaker.BODY_PARTS[npc_type].belt[randi()%NpcMaker.BODY_PARTS[npc_type].belt.size()]
			var c8: Color = NpcMaker.get_color_by_style(style)
			var r8: float = randf()
			npc_id.set_part(t8, c8 ,r8, 0.0)

	# clothes
	if randf() > .6:
		var t10: String = NpcMaker.BODY_PARTS[npc_type].bodysuit[randi()%NpcMaker.BODY_PARTS[npc_type].bodysuit.size()]
		var c10: Color = NpcMaker.get_color_by_style(style)
		var r10: float = randf()
		var m10: float = 0.3*randf()
		npc_id.set_part(t10, c10 ,r10, m10)

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

# amination
	npc_id.set_animation(npc_type, animation_set)


#
# Use these signals to start/end interactions with player
# Remember to configure Collision Mast in NPCArea
#
func npc_area_enter(body):
	NpcMaker.emit_signal("npc_area_entered", self, body)

func npc_area_exit(body):
	NpcMaker.emit_signal("npc_area_exited", self, body)
