extends CanvasLayer

@onready var shader_material = $GBShader.get_material()
@onready var pal_color_indices = range(1,5)
@onready var pal_color = "GREEN"

func _ready():
	setup_color_replacement()

func setup_color_replacement():
	for n in range(1,5):
		var RGBcolor = ProjectSettings.get_setting("shader_globals/SHADER_BASE"+str(n))
		shader_material.set("shader_param/OLDCOLOR"+str(n), RGBcolor["value"])

func set_screen_color(new_color):
	pal_color = new_color
	recalculate_screen_palettes()

func cycle_palettes_down():
	var new_pal_color_indices
	
	match pal_color_indices:
		[1, 1, 1, 1]:
			new_pal_color_indices = [1, 1, 1, 2]
		[1, 1, 1, 2]:
			new_pal_color_indices = [1, 1, 2, 3]
		[1, 1, 2, 3]:
			new_pal_color_indices = [1, 2, 3, 4]
		[1, 2, 3, 4]:
			new_pal_color_indices = [2, 3, 4, 4]
		[2, 3, 4, 4]:
			new_pal_color_indices = [3, 4, 4, 4]
		[3, 4, 4, 4]:
			new_pal_color_indices = [4, 4, 4, 4]
		_:
			new_pal_color_indices = pal_color_indices
	
	if (new_pal_color_indices != pal_color_indices):
		pal_color_indices = new_pal_color_indices
		recalculate_screen_palettes()
		
func cycle_palettes_up():
	var new_pal_color_indices
	
	match pal_color_indices:
		[1, 1, 1, 2]:
			new_pal_color_indices = [1, 1, 1, 1]
		[1, 1, 2, 3]:
			new_pal_color_indices = [1, 1, 1, 2]
		[1, 2, 3, 4]:
			new_pal_color_indices = [1, 1, 2, 3]
		[2, 3, 4, 4]:
			new_pal_color_indices = [1, 2, 3, 4]
		[3, 4, 4, 4]:
			new_pal_color_indices = [2, 3, 4, 4]
		[4, 4, 4, 4]:
			new_pal_color_indices = [3, 4, 4, 4]
		_:
			new_pal_color_indices = pal_color_indices
	
	if (new_pal_color_indices != pal_color_indices):
		pal_color_indices = new_pal_color_indices
		recalculate_screen_palettes()

func recalculate_screen_palettes():
	for n in range(1,5):
		var RGBcolor = ProjectSettings.get_setting("shader_globals/SHADER_"+pal_color+str(pal_color_indices[n-1]))
		shader_material.set("shader_param/NEWCOLOR"+str(n), RGBcolor["value"])
