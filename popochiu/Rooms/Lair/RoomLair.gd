tool
extends PopochiuRoom

const COLOR_BURN := Color('488885')

onready var tween := $Tween


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	C.player.position = get_point('Entrance')
	C.get_character('Chiquininin').disable(false)
	get_prop('Key').disable(false)
	
	if Globals.state.ROBERTO_KILLED:
		C.get_character('Roberto').disable(false)
		
		if not Globals.state.CHIQUINININ_FREED:
			yield(E.run([place_popochius(false)]), 'completed')
			free_characters()
		
		if not I.is_item_in_inventory('Key')\
		and not Globals.state.CHIQUINININ_FREED:
			get_prop('Key').enable(false)


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	if not Globals.state.ROBERTO_KILLED:
		D.show_dialog('RobertoConfrontation')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func place_popochius(wait := true) -> void:
	yield()
	
	var idx := 2
	
	C.player.can_move = false
	
	for p in Globals.packed_popochius:
		var chr: PopochiuCharacter = C.get_character(p)
		chr.can_move = false
		chr.position = get_point('Entrance%d' % idx)
		add_character(chr)
		chr.face_right(false)
		idx += 1
		
		if not E.cutscene_skipped and wait:
			yield(get_tree().create_timer(1), 'timeout')
	
	Globals.packed_popochius.clear()
	
	yield(get_tree(), 'idle_frame')


func free_characters() -> void:
	for c in $Characters.get_children():
		if c.script_name == 'Chiquininin': continue
		c.can_move = true


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
