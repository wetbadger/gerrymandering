extends Node2D

var seat = load("res://UI/EndGame/Seats/Seat.tscn")

var seat_list = []
var max_scale = 1
onready var endgame_scene = get_parent()

func _ready():
	var tally = 0
	var data = Globals.chamber_of_legislation["Tutoria"]

	var center = get_viewport_rect().get_center()
	var seats = data["seats"]
	var parties = data["parties"]
	for lvl in seats:
		for district in seats[lvl]:
			var party_name = district.keys()[0]
			var s = seat.instance()
			
			
			
			
			var added = false
			if len(seat_list) < 1:
				s.set_position(Vector2(center.x-50, center.y))
				added = true
			else:
				var sum = Vector2(0,0)
				var tally2 = 0
				for x in seat_list.size():
					var value = seat_list[-x-1]
					if value.color == parties[party_name]["color"]:
						sum += seat_list[-x-1].get_position()
						tally2+=1
						added = true
				if tally2 > 0:
					s.set_position(sum / tally2)

				
			if not added:
				s.set_position(Vector2(center.x+50, center.y))

				
			add_child(s)
			if is_instance_valid(endgame_scene):
				endgame_scene.dist_seats[party_name].text = str(int(endgame_scene.dist_seats[party_name].text) + 1)
			s.set_color(parties[party_name]["color"])
			s.party = party_name
			seat_list.append(s)
			
			var t = Timer.new()
			t.set_wait_time(0.1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			tally += 1
	
func shrink():
	max_scale -= 0.01
	for node in seat_list:
		node.max_scale = max_scale - 0.01
		while node.scale.x >= max_scale:
			node.scale -= Vector2(0.01, 0.01)
