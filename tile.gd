extends Node2D

@export var type = 0
var coords = [-999, -999]
var entropy = Globals.tile_type_count
var weighted_entropy = Globals.tile_types.keys().slice(1)
var possibilities = Globals.tile_types.keys().slice(1)
var updated = false
var is_selected = false
var time = 0

func _ready() -> void:
	if type:
		inherit_type()

func collapse():
	type = weighted_entropy.pick_random()
	inherit_type()
	update_neighbors()

func update_neighbors(depth = 0):
	get_parent().get_child_at(coords[0] - 1, coords[1]).update_entropy(depth)
	get_parent().get_child_at(coords[0] + 1, coords[1]).update_entropy(depth)
	get_parent().get_child_at(coords[0], coords[1] - 1).update_entropy(depth)
	get_parent().get_child_at(coords[0], coords[1] + 1).update_entropy(depth)
	
func inherit_type():
	entropy = 999
	$Label.text = str(entropy) if entropy != 999 else 'T' + str(type)
	$ColorRect.color = Globals.tile_types[type][1]

func _process(delta: float) -> void:
	time += delta
	if time >= 0.5 and is_selected:
		time = 0
		# print("poss: ", possibilities)
		# print("wentropy: ", weighted_entropy)
		
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
	
func update_entropy(depth = 0):
	if not updated:
		updated = true
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
				weighted_entropy = []
				var possible_possibilities = {}
				for poss in possibilities:
					possible_possibilities[poss] = true
				for neighbor in [
					get_parent().get_child_at(coords[0] - 1, coords[1]),
					get_parent().get_child_at(coords[0] + 1, coords[1]),
					get_parent().get_child_at(coords[0], coords[1] - 1),
					get_parent().get_child_at(coords[0], coords[1] + 1)]:
					var exists = false
					for pos in possible_possibilities.keys():
						exists = false
						for neighposs in neighbor.possibilities:
							if pos in Globals.tile_types[neighposs][0]:
								exists = true
						if not exists:
							possible_possibilities[pos] = false
				for key in possible_possibilities.keys():
					if possible_possibilities[key]:
						weighted_entropy.append(key)
			var temp_dict = Dictionary()
			for item in weighted_entropy:
				temp_dict[item] = true
			entropy = len(temp_dict.keys())
			possibilities = temp_dict.keys().duplicate()
			if entropy == 0:
				entropy = 999
			update_neighbors(depth + 1)
		elif get_parent():
			entropy = 999
		$Label.text = str(entropy) if entropy != 999 else 'T' + str(type)


func _on_color_rect_mouse_entered() -> void:
	is_selected = true


func _on_color_rect_mouse_exited() -> void:
	is_selected = false
