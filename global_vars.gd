extends Node
# List of each tile type that can be next to it, Color, Name
var tile_types: Dictionary = {
	0: [[], Color.WHITE, "Undecided"],
	1: [[1, 1, 1, 1, 1, 1, 1, 2, 3], Color.WEB_GREEN, "Grass"],
	2: [[2, 2, 2, 2, 2, 2, 2, 2, 1, 1], Color.DARK_GREEN, "Forest"],
	3: [[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 4, 4], Color.BISQUE, "Sand"],
	4: [[4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3], Color.NAVY_BLUE, "Water"]
	}

var tile_type_count = 5
