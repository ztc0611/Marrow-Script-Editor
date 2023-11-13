extends Node

var internet_version = ""
var link = "https://pastebin.com/raw/5QgnQtRL"

func _ready():
	self.text = Version.version + "  "
	
	$HTTPRequest.request_completed.connect(_on_request_completed)
	request()

var timer_max = 60*10
var timer = timer_max
func _process(delta):
	timer -= delta
	if timer < 0:
		timer = timer_max
		request()

func request():
	print("checking for update...")
	$HTTPRequest.request(link)

func _on_request_completed(result, response_code, headers, body):
	body = body.get_string_from_utf8()
	internet_version = body
	check_difference()

func check_difference():
	var a = Version.version.split(".")
	var b = internet_version.split(".")
	
	var a_i = int(a[0])*1000+int(a[1])*100+int(a[2])
	var b_i = int(b[0])*1000+int(b[1])*100+int(b[2])
	
	if b_i > a_i:
		self.text = "Out of date!!!!"
