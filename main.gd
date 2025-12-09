extends SubViewport

var tile = preload("tile.tscn")
var grid = []
var temp
const width = 14
const height = 14
const base_delay = 0.01
var delay = base_delay
var start = [
	[[width / 2 - 2, width / 2 - 1, width / 2, width / 2 + 1, width / 2 + 2].pick_random(), 
	[height / 2 - 2, height / 2 - 1, height / 2, height / 2 + 1, height / 2 + 2].pick_random()]]
var choices = [[1, 2, 3, 5, 6, 7, 8, 9, 10, 12],]

func _process(delta: float) -> void:
	if Input.is_action_pressed('ui_accept'):
		delay = base_delay * 10
	else:
		delay = base_delay

func _ready() -> void:
	Globals.dont_retry = false
	$Camera.offset = Vector2(width*32, height*32)
	# start = [[3, 3], [9, 9]]
	# choices = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]]
	var special = []
	for i in width:
		grid.append([])
		for j in height:
			temp = tile.instantiate()
			temp.position = Vector2(64 * i, 64 * j)
			temp.coords = [i, j]
			if [i, j] in start:
				temp.type = choices.pop_front().pick_random()
				temp.inherit_type()
				special.append(temp)
				start.pop_front()
			grid[-1].append(temp)
			add_child(temp)
	for spec in special:
		spec.update_neighbors()
	collapse()

func collapse():
	var lowest_entropy = 999
	var lowest_child = false
	var options = get_children().slice(1)
	var child
	while options:
		child = options.pick_random()
		child.updated = false
		if child.entropy < lowest_entropy:
			lowest_child = child
			lowest_entropy = child.entropy
		options.erase(child)
	if lowest_child:
		lowest_child.get_child(0).color = Color.DEEP_PINK
		# await get_tree().create_timer(delay).timeout
		lowest_child.collapse()
		await get_tree().create_timer(delay).timeout
		collapse()
	else:
		await get_tree().create_timer(0.3).timeout
		var gridn = []
		for i in grid:
			gridn.append([])
			for j in i:
				gridn[-1].append([j.get_child(0).color, Globals.tile_types[j.type][3]])
		Globals.grid = gridn
		get_tree().change_scene_to_file("res://walking_around.tscn")

func get_child_at(x, y):
	if -1 < x and x < len(grid):
		if -1 < y and y < len(grid[x]):
			return grid[x][y]
	return tile.instantiate()
