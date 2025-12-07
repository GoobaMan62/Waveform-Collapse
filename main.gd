extends Node2D

var tile = preload("tile.tscn")
var grid = []
var temp
const width = 24
const height = 12
var start = [
	[width / 2 - 2, width / 2 - 1, width / 2, width / 2 + 1, width / 2 + 2].pick_random(), 
	[height / 2 - 2, height / 2 - 1, height / 2, height / 2 + 1, height / 2 + 2].pick_random()]

func _ready() -> void:
	var special
	for i in 32:
		grid.append([])
		for j in 16:
			temp = tile.instantiate()
			temp.position = Vector2(64 * i, 64 * j)
			temp.coords = [i, j]
			if i == start[0] and j == start[1]:
				temp.type = 1
				temp.inherit_type()
				special = temp
			grid[-1].append(temp)
			add_child(temp)
	special.update_neighbors()
	collapse()

func collapse():
	var lowest_entropy = 999
	var lowest_child = false
	print("updated_entropies")
	var options = get_children()
	var child
	while options:
		child = options.pick_random()
		if child.entropy < lowest_entropy:
			lowest_child = child
			lowest_entropy = child.entropy
		options.erase(child)
	if lowest_entropy < 300 and lowest_child.type == 0:
		lowest_child.get_child(0).color = Color.DEEP_PINK
		print("lentropy ", lowest_entropy)
		await get_tree().create_timer(0.5).timeout
		lowest_child.collapse()
		await get_tree().create_timer(0.5).timeout
		collapse()

func get_child_at(x, y):
	print("getting_at ", x, " ", y)
	if x < len(grid):
		if y < len(grid[x]):
			print("return")
			return grid[x][y]
	print("isthisbreakingit")
	return tile.instantiate()
