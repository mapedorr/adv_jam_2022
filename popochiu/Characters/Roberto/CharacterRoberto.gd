tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	E.run([
		"Player: We'd better not approach without having something to protect ourselves with."
	])


# When the node is right clicked
func on_look() -> void:
	E.run([
		'Player: He is... disgusting',
		'Roberto: Hey!!!! I heard that!!!'
	])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == 'Knife':
		C.player = C.get_character('Gonorrein')
		C.player.play_knife()
		
		yield(E.run([
			C.walk_to_clicked(),
			"Gonorrein: Die monster. You don't belong in this world.",
			# TODO: Hacer algo medio animado...
			'Roberto: Oh my #$!@*...!',
			C.get_character('Roberto').disable(),
			I.set_active_item(),
			# TODO: Sonido de popó de LBA2...
			# TODO: Sonido de llave cayendo al suelo.
			E.current_room.get_prop('Key').enable(),
			'Goddiu: Look! He threw a key!',
		]), 'completed')
		
		Globals.in_roberto_dialog = false
		E.current_room.free_characters()
	else:
		E.run([
			"Player: Hitting him with it won't do any good."
		])


# Use it to play the idle animation for the character
func play_idle() -> void:
	pass


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func play_walk(target_pos: Vector2) -> void:
	.play_walk(target_pos)


# Use it to play the talk animation for the character
func play_talk() -> void:
	pass


# Use it to play the grab animation for the character
func play_grab() -> void:
	pass
