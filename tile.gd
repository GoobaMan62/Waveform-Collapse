extends Node2D

@export var type = 0
var coords = [-999, -999]
var entropy = Globals.tile_type_count
var weighted_entropy = []

func _ready() -> void:
	if type:
		inherit_type()

func collapse():
	type = weighted_entropy.pick_random()
	inherit_type()
	update_neighbors()

func update_neighbors():
	get_parent().get_child_at(coords[0] - 1, coords[1]).update_entropy()
	get_parent().get_child_at(coords[0] + 1, coords[1]).update_entropy()
	get_parent().get_child_at(coords[0], coords[1] - 1).update_entropy()
	get_parent().get_child_at(coords[0], coords[1] + 1).update_entropy()
	
func inherit_type():
	entropy = 999
	$Label.text = str(entropy) if entropy != 999 else 'T' + str(type)
	$ColorRect.color = Globals.tile_types[type][1]

func add_to_weighted_entropy(list_to_add):
	if list_to_add:
		var items_to_erase = []
		for item in weighted_entropy:
			if not (item in list_to_add):
				items_to_erase.append(item)
		for item in items_to_erase:
			weighted_entropy.erase(item)
		for item in list_to_add:
			if item in weighted_entropy:
				weighted_entropy.append(item)
			
func update_entropy():
	if type == 0 and get_parent():
		if get_parent().get_child_at(coords[0] - 1, coords[1]).type > 0:
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0] - 1, coords[1]).type)[0].duplicate()
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0] + 1, coords[1]).type)[0].duplicate())
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0].duplicate())
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0].duplicate())
		elif get_parent().get_child_at(coords[0] + 1, coords[1]).type > 0:
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0] + 1, coords[1]).type)[0].duplicate()
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0].duplicate())
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0].duplicate())
		elif get_parent().get_child_at(coords[0], coords[1] - 1).type > 0:
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0].duplicate()
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0].duplicate())
		elif get_parent().get_child_at(coords[0], coords[1] + 1).type > 0:
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0].duplicate()
		else:
			weighted_entropy = [1, 2, 3, 4]
		var temp_dict = Dictionary()
		for item in weighted_entropy:
			temp_dict[item] = true
		entropy = len(temp_dict.keys())
		if entropy == 0:
			entropy = 999
	else:
		entropy = 999
	$Label.text = str(entropy) if entropy != 999 else 'T' + str(type)
