extends Label

var day
var month
var year

func _process(delta):
	day = OS.get_datetime()["day"]
	month = OS.get_datetime()["month"]
	year = OS.get_datetime()["year"]

	if day < 10:
		day = "0" + str(day)
	if month < 10:
		month = "0" + str(month)
	if year < 10:
		year = "0" + str(year)

	$cur_date.text = str(day) + "." + str(month) + "." + str(year)
