extends Node

var Pausable: bool = true
var GravityOn: bool = true

var PauseMenu: Control
var SettingsMenu: Control
var MusicMenu: Control

var CanUnpause: bool = false

var Scene_Room: PackedScene = preload("res://scenes/room.tscn")
var Scene_Club: PackedScene = preload("res://scenes/club.tscn")


# SETTINGS

var Resolution: Array
var ResolutionIndex: int
var Fullscreen: bool
var VSync: bool
var Resizable: bool
var FPS_Cap: int
var Master_Volume: int
var Effect_Volume: int
var Music_Volume: int


func _ready():
	_LoadSettingsData()

### SETTINGS METHODS

# Don't call this, call _LoadSettingsData() instead
func _ReadSettingsData() -> Dictionary:
	if !FileAccess.file_exists("user://settingsdata.dat"):
		self.Resolution = [1152, 648]
		self.ResolutionIndex = 0
		self.Fullscreen = false
		self.VSync = false
		self.Resizable = true
		self.FPS_Cap = -1
		self.Master_Volume = -10
		self.Effect_Volume = -10
		self.Music_Volume = -10
		SaveSettingsData()
	return JSON.parse_string(FileAccess.open("user://settingsdata.dat", FileAccess.READ).get_as_text())

func _SettingsData_Dict() -> Dictionary:
	return {"Resolution":Resolution,"ResolutionIndex":ResolutionIndex,"Fullscreen":Fullscreen,\
	"VSync":VSync,"Resizable":Resizable,"FPS_Cap":FPS_Cap,"Master_Volume":Master_Volume,\
	"Effect_Volume":Effect_Volume,"Music_Volume":Music_Volume}

func SaveSettingsData():
	var file = FileAccess.open("user://settingsdata.dat",FileAccess.WRITE)
	file.store_string(JSON.stringify(_SettingsData_Dict()))
	file.close()

func _LoadSettingsData():
	var data: Dictionary = _ReadSettingsData()
	self.Resolution = data.get("Resolution")
	self.ResolutionIndex = data.get("ResolutionIndex")
	self.Fullscreen = data.get("Fullscreen")
	self.VSync = data.get("VSync")
	self.Resizable = data.get("Resizable")
	self.FPS_Cap = data.get("FPS_Cap")
	self.Master_Volume = data.get("Master_Volume")
	self.Effect_Volume = data.get("Effect_Volume")
	self.Music_Volume = data.get("Music_Volume")
	ApplySettings()

func ApplySettings():
	get_window().size = Vector2i(self.Resolution[0], self.Resolution[1])
	
	if self.Fullscreen: get_window().set_mode(Window.MODE_FULLSCREEN)
	elif get_window().get_mode() == Window.MODE_MAXIMIZED: pass
	else: get_window().set_mode(Window.MODE_WINDOWED)
	
	if self.VSync: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	if self.Resizable: get_window().unresizable = false
	else: get_window().unresizable = true
	
	SaveSettingsData()
