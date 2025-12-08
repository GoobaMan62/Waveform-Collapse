extends Node
# List of each tile type that can be next to it, Color, Name
var tile_types: Dictionary = {
	0: [[], Color.WHITE, "Undecided"],
	1: [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 7, 9], Color.WEB_GREEN, "Grass"],
	2: [[2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 5, 5], Color.DARK_GREEN, "Forest"],
	3: [[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 4, 4, 7], Color.BISQUE, "Beach"],
	4: [[4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3], Color.NAVY_BLUE, "Water"],
	5: [[5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 2], Color.LIGHT_STEEL_BLUE, "Snow"],
	6: [[6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 9, 9], Color.LIGHT_CYAN, "Ice"],
	7: [[7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 1, 3], Color.BURLYWOOD, "Desert"],
	8: [[8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 9], Color.CRIMSON, "Scorching"],
	9: [[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 1, 7, 8, 10, 10, 6], Color.WEB_GRAY, "Rocky"],
	10: [[10, 10, 10, 10, 10, 10, 9, 9, 9, 9], Color.DIM_GRAY, "Mountain"]
	}

var tile_type_count = len(tile_types)
