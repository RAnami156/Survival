extends Node2D
var AppID = "480"
func _init() -> void:
	OS.set_environment("SteamAppID", AppID)
	OS.set_environment("SteamGameID", AppID)
func _ready() -> void:
	Steam.steamInit()
	var isRunning = Steam.isSteamRunning()

	if !isRunning :
		print("Steam not running")
		return

	print("Steam is running")

	var id = Steam.getSteamID()
	var name = Steam.getFriendPersonaName(id)
	print("Username:", str(name))
