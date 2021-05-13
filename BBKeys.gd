extends Node

# This is a singleton!
var enabled : bool = true

# Files/Directories classes
var FileClass : File = File.new()
var DirectoryClass : Directory = Directory.new()
var image_default_format : String = ".png"

# Debug variables
var debug_prints : bool = true # Disable at release

# Layouts
var default_root_layout_folder : String = "keycons" # DO NOT INCLUDE A "/" AT THE END! - Without res://, it will consider automatically that you are referencing the res folder
var layout_folders : Array = ["Keyboard & Mouse","PS4","PS5","Switch","Xbox One","Xbox Series X","Amazon Luna","Arrows","Gestures","Google Stadia","Ouya","PS Move","PS Vita","PS3","Steam","Switch","VR","Wii","WiiU","Xbox 360","Others"]

func layout_exists(layout):
	if enabled:
		return DirectoryClass.dir_exists(default_root_layout_folder + "/" + layout)

func key_exists(layout, key):
	if enabled and key:
		var key_file = default_root_layout_folder + "/" + layout + "/" + key + image_default_format
		return key_file

func get_key_image(layout, key):
	if enabled and layout and key:
		if layout_exists(layout):
			if key_exists(layout, key):
				var path = default_root_layout_folder + "/" + layout + "/" + key + image_default_format
				return path

func _ready():
	if enabled:
		if debug_prints:
			print("[BBKeys] BBKeys is initializing...")
			print("[BBKeys] BBKeys default root layout folder is: " + default_root_layout_folder + ", checking...")
		if !DirectoryClass.dir_exists(default_root_layout_folder):
			if debug_prints:
				push_error("[BBKeys] Error: Default root layout folder was not found, disabling itself.")
			enabled = false
			return
		for layout in layout_folders:
			if !layout_exists(layout):
				if debug_prints:
					push_error("[BBKeys] Error: layout index \"" + layout + "\" does not exist, disabling itself." )
				enabled = false
				return
			else:
				print("[BBKeys] Layout " + layout + " has been succesfully initiated.")
		print("[BBKeys] BBKeys has been successfully initiated.")

func return_keymage(layout, key, horizontal_width, vertical_height):
	if enabled and layout and key and horizontal_width and vertical_height:
		if layout_exists(layout):
			var final = "[img=" + str(horizontal_width) + "x" + str(vertical_height) + "]" + get_key_image(layout, key) + "[/img]"
			if debug_prints:
				print("[BBKeys] Successfully returned out: `" + final + "`.")
			return final
