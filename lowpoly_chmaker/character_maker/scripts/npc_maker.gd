extends Node


signal set_color
signal set_roughness
signal set_metalness
signal next_item
signal remove_item

signal direct_add_item
signal direct_remove_item

signal npc_save
signal npc_load

signal npc_area_entered
signal npc_area_exited


const BODY_PARTS = {"male":{"belt":["male_belt_1","male_belt_2","male_belt_3","male_belt_4"],
"bodysuit":["male_body_1","male_body_2","male_body_3"],
"browns":["male_browns_1","male_browns_2","male_browns_3","male_browns_4"],
"cyber":["male_cyber_1", "male_cyber_2","male_cyber_3"],
"eyes":["male_eyes_1","male_eyes_2","male_eyes_3","male_eyes_4"],
"facial": ["male_beard_1", "male_beard_2", "male_beard_3", "male_beard_4", "male_beard_5"],
"glasses":["male_glasses_1", "male_glasses_2", "male_glasses_3", "male_glasses_4", "male_glasses_5"],
"hair":["male_hair_1","male_hair_2","male_hair_3","male_hair_4","male_hair_5","male_hair_6", "male_hair_7", "male_hair_8"],
"jacket": ["male_jacket_1", "male_jacket_2"],
"mouth":["male_mouth_1","male_mouth_2","male_mouth_3"],
"pants":["male_pants_1","male_pants_2","male_pants_3"],
"shirt":["male_shirt_1","male_shirt_2","male_shirt_3"],
"shoes":["male_shoes_1","male_shoes_2"],
"animation": {
"standing": ["male_idle_1", "male_idle_2", "male_idle_3", "male_idle_4"],
"seated": ["male_seat_1", "male_seat_2", "male_seat_3"],
"working": ["male_working_1", "male_working_2", "male_working_3", "male_working_4"],
"sleeping": ["male_sleep"]}},
"female":{"belt":["female_belt_1","female_belt_2","female_belt_3", "female_belt_3"],
"bodysuit":["female_body_1","female_body_2","female_body_3","female_body_4"],
"browns":["female_browns_1","female_browns_2","female_browns_3","female_browns_4"],
"cyber":["female_cyber_1", "female_cyber_2","female_cyber_3"],
"eyes":["female_eye_1","female_eye_2","female_eye_3"],
"glasses":["female_glasses_1", "female_glasses_2", "female_glasses_3", "female_glasses_4", "female_glasses_5", "female_glasses_6"],
"hair":["female_hair_1","female_hair_2","female_hair_3","female_hair_4","female_hair_5","female_hair_6", "female_hair_7", "female_hair_8", "female_hair_9"],
"jacket": ["female_jacket_1", "female_jacket_2"],
"mouth":["female_mouth_1","female_mouth_2","female_mouth_3","female_mouth_4"],
"pants":["female_pants_1","female_pants_2","female_pants_3","female_pants_4"],
"shirt":["female_shirt_1","female_shirt_2","female_shirt_3","female_shirt_4","female_shirt_5"],
"shoes":["female_shoes_1","female_shoes_2","female_shoes_3"],
"animation":{
"standing": ["female_idle_1", "female_idle_2", "female_idle_3", "female_idle_3"],
"seated": ["female_seat_1", "female_seat_2", "female_seat_3"],
"working": ["female_working_1", "female_working_2", "female_working_3", "female_working_4"],
"sleeping": ["female_sleep"]}}}

# "standing", "seated", "working", "sleeping"

const PERSONA = {
"SKIN_COLOR" : ["dfd2c8", "ffe4d1", "ffc399", "ebc2a6", "e2c1aa", "ffcba7","ffba8a", "e19d66","bf7942","935d34","6d4425"],
"EYES_COLOR" : ["0b0908","21140a","4e2e18","5d5737","1c4522","144954","2d393f"],
"MOUTH_COLOR" : ["a44c2e", "994220", "e26060", "de4d4d", "ca3636", "881919"],
"HAIR_COLOR" : ["adadad", "e1dd78", "d45d2e", "92562b", "6a4830", "2a221f", "531103", "353535","141414"]}

const SHOES_COLOR = ["181818", "424242", "210505", "2f1a08", "062524", "39270d", "989898"]

const CLOTHES_BASE_COLOR = ["d2d2d2", "3c3c3c", "a82020", "5d8f1b", "1b4c07", "142835", "204760", "3b7d7f", "b6b01a", "68820b", "aa1a02", "8a103b"]

const STYLE = {
	"DARK": ["2C3333", "395B64", "A5C9CA", "21353B"],
	"EVIL": ["040303", "461111", "A13333", "B3541E"],
	"PEACE": ["F0EBE3", "E4DCCF", "7D9D9C", "576F72"],
	"EARTH": ["87805E", "B09B71", "D8CCA3", "EDDFB3"],
	"FIRE": ["630606", "890F0D", "E83A14", "D9CE3F"],
	"NAVAL": ["009DAE", "71DFE7", "C2FFF9", "FFE652"],
	"LIGHT": ["F4F9F9", "CCF2F4", "A4EBF3", "AAAAAA"],
	"NONE": ["", "", "", ""],
}

const STYLES = ["DARK", "EVIL", "PEACE", "EARTH", "FIRE", "NAVAL", "LIGHT"]

#enum npc_type { FEMALE_STANDARD = 1, MALE_STANDARD = 2}



#func _ready():
#	load_body_dictionary()
#	get_color_by_style("DARK")


func get_skin_color():
	return PERSONA.SKIN_COLOR[randi() % PERSONA.SKIN_COLOR.size()]

func get_eyes_color():
	return PERSONA.EYES_COLOR[randi() % PERSONA.EYES_COLOR.size()]

func get_mouth_color():
	return PERSONA.MOUTH_COLOR[randi() % PERSONA.MOUTH_COLOR.size()]

func get_hair_color():
	return PERSONA.HAIR_COLOR[randi() % PERSONA.HAIR_COLOR.size()]


func get_color_by_style(style: String):
	var cc: Color = Color(STYLE[style][randi()%STYLE[style].size()])
	
	var v1: float = clamp(cc.r + 0.05 - (0.1*randf()), 0.0, 1.0)
	var v2: float = clamp(cc.g + 0.05 - (0.1*randf()), 0.0, 1.0)
	var v3: float = clamp(cc.b + 0.05 - (0.1*randf()), 0.0, 1.0)

	return Color(v1, v2, v3)


func get_animation(npc_type: String, animation_group: String):
	var animation_selected = BODY_PARTS[npc_type].animation[animation_group][randi()%BODY_PARTS[npc_type].animation[animation_group].size()]
	return animation_selected
