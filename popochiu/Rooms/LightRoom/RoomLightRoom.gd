tool
extends PopochiuRoom

const COLOR_BURN := Color('eaaded')

onready var _bg_sprite: Sprite = get_prop('Bg').get_node('Sprite')
onready var _switch_sprite: Sprite = get_prop('Switch').get_node('Sprite')
onready var _lamp_sprite: Sprite = get_prop('Lamp').get_node('Sprite')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░



# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	C.player.position = get_point('Entrance')
	
	toggle_light(Globals.state.LIGHT_ROOM_ON)


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	yield(E.run([]), 'completed')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func toggle_light(is_on: bool) -> void:
	Globals.state.LIGHT_ROOM_ON = is_on
	$Light.material.set_shader_param(
		'color1', Color(Globals.state.LIGHT_ROOM_COLOR)
	)
	
	_lamp_sprite.frame = 2\
	if Globals.state.LIGHT_ROOM_COLOR == Globals.PINK_LIGHT else 1
	
	if is_on:
		_bg_sprite.frame = 1
		_switch_sprite.frame = 1
		
		$Light.show()
		
		get_prop('Page').appear()
	else:
		_bg_sprite.frame = 0
		_switch_sprite.frame = 0
		
		get_prop('Page').disable(false)
		$Light.hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
