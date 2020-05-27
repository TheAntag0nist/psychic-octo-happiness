extends Node

const ICON_PATH="res://icons/"

const ITEMS={
	"sword":{
		"icon" : ICON_PATH+"sword.png",
		"slot" : "MAIN_HAND"
	},
	"sword_1":{
		"icon" : ICON_PATH+"sword_1.png",
		"slot" : "MAIN_HAND"
	},
	"heavy_sword":{
		"icon" : ICON_PATH+"heavy_sword.png",
		"slot" : "MAIN_HAND"
	},
	"base_armor":{
		"icon" : ICON_PATH+"base_armor.png",
		"slot" : "CHEST"
	},
	"cape":{
		"icon" : ICON_PATH+"cape.png",
		"slot" : "CHEST"
	},
	"error":{
		"icon" : ICON_PATH+"error.png",
		"slot" : "NONE"
	}
}

func get_item(item_id):
	if item_id in ITEMS:
		return ITEMS[item_id]
	else:
		return ITEMS["error"]
