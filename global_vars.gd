extends TextureRect
# List of each tile type that can be next to it, Color, Name, Height
var tile_types: Dictionary = {
	0: [[], Color.BLACK, "Undecided", 0],
	1: [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 7, 9, 1, 1, 1, 2, 2, 2, 3, 7, 9, 12], Color.WEB_GREEN, "Grass", 3],
	2: [[2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 5, 5], Color.DARK_GREEN, "Forest", 3],
	3: [[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 4, 4, 7], Color.BISQUE, "Beach", 2.75],
	4: [[11, 11, 11, 11, 11, 11, 4, 4, 4, 4, 3, 11, 11, 11, 11, 11, 11, 4, 4, 4, 4, 3], Color.DARK_BLUE, "ShallowWater", 2],
	5: [[5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 2, 2, 9], Color.LIGHT_STEEL_BLUE, "Snow", 3.5],
	6: [[6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 9, 9], Color.LIGHT_CYAN, "Ice", 3.75],
	7: [[7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 9, 9, 9, 1, 3], Color.BURLYWOOD, "Desert", 2.8],
	8: [[8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 9], Color.DARK_GOLDENROD, "Scorching", 2.65],
	9: [[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 1, 7, 8, 10, 10, 6, 5], Color.WEB_GRAY, "Rocky", 3.25],
	10: [[10, 10, 10, 10, 10, 10, 9, 9, 9, 9], Color.DIM_GRAY, "Mountain", 4.25],
	11: [[11, 11, 11, 11, 11, 11, 11, 4, 4, 4], Color.NAVY_BLUE, "DeepWater", 1.5],
	12: [[12, 12, 1], Color.AQUAMARINE, "MysticField", 3.25]
	}

var tile_type_count = len(tile_types)
var dont_retry = false

var grid

func set_mapview(image: ImageTexture):
	image.get_image()
	var img = image.get_image()
	img.resize(64, 64)
	image.set_image(img)
	texture = image
