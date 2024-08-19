extends CanvasLayer

@onready var shader_material = $GBShader.get_material()
@onready var pal_color_indices = range(1,5):
	set(value):
		pal_color_indices = value
		recalculate_screen_palettes()
@onready var pal_color = "GREEN":
	set(value):
		pal_color = value
		recalculate_screen_palettes()

func _ready():
	setup_color_replacement()

func set_screen_color(new_color):
	pal_color = new_color

func reset_default_palette_range():
	pal_color_indices = [1, 2, 3, 4]

func blackout_screen():
	pal_color_indices = [4, 4, 4, 4]

func whiteout_screen():
	pal_color_indices = [1, 1, 1, 1]

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

func setup_color_replacement():
	var base_colors = []
	for n in range(1,5):
		var RGBcolor = ProjectSettings.get_setting("shader_globals/SHADER_BASE"+str(n))
		base_colors.append(RGBcolor["value"]);
		
	shader_material.set("shader_parameter/OLD_COLORS", base_colors);

func recalculate_screen_palettes():
	var new_colors = []
	for n in range(1,5):
		var RGBcolor = ProjectSettings.get_setting("shader_globals/SHADER_"+pal_color+str(pal_color_indices[n-1]))
		new_colors.append(RGBcolor["value"]);
	
	shader_material.set("shader_parameter/NEW_COLORS", new_colors);
	DisplayServer.set_native_icon("marty_icon_"+pal_color.to_lower()+".ico");
