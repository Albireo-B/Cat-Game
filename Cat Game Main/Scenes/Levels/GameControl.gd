extends Control

var active_Room = ALL_ROOMS.Livingroom

enum ALL_ROOMS{
	Hall_Bath_Living,
	Bathroom,
	Livingroom
}

func _ready():
	for numRoom in ALL_ROOMS.values():
		if(numRoom < 1) :
			get_node("Corridors").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(0.4,0.4,0.4, 0.8)
		else:
			get_node("Rooms").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(0.4,0.4,0.4, 0.8)


func _on_HallArea2D_body_entered(body):
	if body.name == "Cat":
		room_vanish(active_Room)
		active_Room = ALL_ROOMS.Hall_Bath_Living
		room_appear(active_Room)


func _on_BathArea2D_body_entered(body):
	if body.name == "Cat":
		room_vanish(active_Room)
		active_Room = ALL_ROOMS.Bathroom
		room_appear(active_Room)


func _on_LivingArea2D_body_entered(body):
	if body.name == "Cat":
		room_vanish(active_Room)
		active_Room = ALL_ROOMS.Livingroom
		room_appear(active_Room)
		
		
func room_vanish(numRoom) :
	if(numRoom != null) :
		if(numRoom < 1) :
			get_node("Corridors").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(0.4,0.4,0.4, 0.8)
		else:
			get_node("Rooms").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(0.4,0.4,0.4, 0.8)

		
func room_appear(numRoom) :
	if(numRoom != null) :
		if(numRoom < 1) :
			get_node("Corridors").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(1,1,1, 1)
		else:
			get_node("Rooms").get_node(ALL_ROOMS.keys()[numRoom]).modulate = Color(1,1,1, 1)
