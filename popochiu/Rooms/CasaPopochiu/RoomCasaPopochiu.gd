tool
extends PopochiuRoom
# warning-ignore-all:return_value_discarded

const COLOR_BURN := Color('BD6868')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func on_room_entered() -> void:
	if C.player.last_room == 'Map':
		C.player.position = get_point('Entrance')


# What happens when the room changing transition finishes. At this point the room
# is visible.
func on_room_transition_finished() -> void:
	if visited_first_time and not I.is_item_in_inventory('Book'):
		Globals.connect('book_closed', self, '_cry_again')
		
		yield(E.run([
			'Goddiu(sad): ******!',
			'Popsy(sad): $$$$$$!',
			'Trapusinsiu(sad): ######!',
		]), 'completed')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _cry_again() -> void:
	if Globals.read_pages.has(Globals.PAGE_CODES.GODDIU_CHIQUINININ):
		Globals.disconnect('book_closed', self, '_cry_again')
		
		yield(E.run([
			'Goddiu: ' + Utils.say_in_popochiu('ay doooooooooooo', 'cries'),
			'Popsy: $$$$$$!!!',
			'Trapusinsiu: ######!!!',
		]), 'completed')
