extends Label

var hour = OS.get_time()["hour"]
var minutes = OS.get_time()["minute"]
var seconds = OS.get_time()["second"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	hour = OS.get_time()["hour"]
	minutes = OS.get_time()["minute"]
	seconds = OS.get_time()["second"]
	if hour>9 && minutes>9 && seconds>9:
		get_node("cur_time").text = str(hour)+":"+str(minutes)+":"+str(seconds)
	elif hour < 10 && minutes < 10 && seconds <10:
		get_node("cur_time").text = "0"+str(hour)+":"+"0"+str(minutes)+":"+"0"+str(seconds)
	elif hour < 10 && minutes<10:
		get_node("cur_time").text = "0"+str(hour)+":"+"0"+str(minutes)+":"+str(seconds)
	elif hour < 10 && seconds<10:
		get_node("cur_time").text = "0"+str(hour)+":"+str(minutes)+":"+"0"+str(seconds)
	elif seconds < 10 && minutes<10:
		get_node("cur_time").text = str(hour)+":"+"0"+str(minutes)+":"+"0"+str(seconds)
	elif hour<10:
		get_node("cur_time").text = "0"+str(hour)+":"+str(minutes)+":"+str(seconds)
	elif minutes<10:
		get_node("cur_time").text = str(hour)+":"+"0"+str(minutes)+":"+str(seconds)
	elif seconds<10:
		get_node("cur_time").text = str(hour)+":"+"0"+str(minutes)+":"+"0"+str(seconds)
