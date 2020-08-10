extends Label

var hour
var minutes
var seconds

var str_h
var str_m = null
var str_s = null

func _process(delta):
	hour = OS.get_time()["hour"]
	minutes = OS.get_time()["minute"]
	seconds = OS.get_time()["second"]
	
	if hour < 10:
		hour = "0" + str(hour)
	if minutes < 10:
		minutes = "0" + str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	
	$cur_time.text = str(hour) + ":" + str(minutes) + ":" + str(seconds)
