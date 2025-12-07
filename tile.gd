extends Node2D

@export var type = 0
var coords = [-999, -999]
var entropy = Globals.tile_type_count
var weighted_entropy = []

func _ready() -> void:
	if type:
		inherit_type()

func collapse():
	print(weighted_entropy)
	type = weighted_entropy.pick_random()
	inherit_type()
	update_neighbors()

func update_neighbors():
	get_parent().get_child_at(coords[0] - 1, coords[1]).update_entropy()
	get_parent().get_child_at(coords[0] + 1, coords[1]).update_entropy()
	get_parent().get_child_at(coords[0], coords[1] - 1).update_entropy()
	get_parent().get_child_at(coords[0], coords[1] + 1).update_entropy()
	
func inherit_type():
	print("type: ", type)
	entropy = 999
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
	if type == 0:
		if get_parent().get_child_at(coords[0] - 1, coords[1]).type > 0:
			print("111111")
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0] - 1, coords[1]).type)[0]
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0] + 1, coords[1]).type)[0])
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0])
			print("CRASHES SOMEWHERE HERE???")
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0])
		elif get_parent().get_child_at(coords[0] + 1, coords[1]).type > 0:
			print("222222")
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0] + 1, coords[1]).type)[0]
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0])
			print("CRASHES SOMEWHERE HERE???")
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0])
		elif get_parent().get_child_at(coords[0], coords[1] - 1).type > 0:
			print("333333")
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] - 1).type)[0]
			print("CRASHES SOMEWHERE HERE???")
			add_to_weighted_entropy(Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0])
		elif get_parent().get_child_at(coords[0], coords[1] + 1).type > 0:
			print("444444")
			weighted_entropy = Globals.tile_types.get(get_parent().get_child_at(coords[0], coords[1] + 1).type)[0]
			print("CRASHES SOMEWHERE HERE???")
		else:
			print("AAAAAA")
			weighted_entropy = [1, 2, 3, 4]
		print("starting_keying")
		var temp_dict = Dictionary()
		for item in weighted_entropy:
			temp_dict[item] = true
		entropy = len(temp_dict.keys())
		print("finished_keying")
		if entropy == 0:
			entropy = 999
		print("entropy ", entropy)
	else:
		entropy = 999
