tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	disable(false)
	
	if Globals.state.SYMBOL_ACTIVATED:
		enable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	if not I.is_item_in_inventory('Translator'):
		yield(E.run([
			'Marcianiu: Ñiñiñiñiñi ñiñiñi ñiñiñiñiñiñi ñiñiñiñiñiñi',
			'Player: What?',
			'Marcianiu: Ñiñiñiñiñi ñiñiñi ñiñiñiñiñiñi ñiñiñiñiñiñi',
			'Player: What?',
		]), 'completed')
		
		return
	
	yield(E.run([
		'Marcianiu: I say hello to you ' + C.player.description
	]), 'completed')


# When the node is right clicked
func on_look() -> void:
	E.run(['Player: Is Marcianiu!!!'])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	if item.script_name == 'IceCream':
		if not I.is_item_in_inventory('Translator'):
			E.run([
				'Marcianiu: Ñiiiiiñiñiñiñi',
				I.remove_item('IceCream')
			])
		else:
			E.run([
				'Marcianiu: Ice cream!!! Yeyyyyyy',
				I.remove_item('IceCream'),
				"Marcianiu: I haven't eaten one in a long time.",
				"Marcianiu: Thank you... and in exchange I'll give you two things to help you find Chiquininín.",
				"Marcianiu: I'm pretty sure it was kidnapped by a Roberto.",
				'Player: ' + Utils.say_in_popochiu('Ay dooooooooooooo!', 'cries'),
				'Marcianiu: No worries. Take this knife. It is quite useful against them.',
				I.add_item('Knife'),
				# TODO: Que coma helado
				"Marcianiu: I love Popsy's ice creams",
				'Marcianiu: And I hope this light will show you the place where Roberto is hiding.',
				I.add_item('Bulb'),
				'Player: Thanks Marcianiu!',
				'Marcianiu: Visit me when you have found Chiquininín.'
			])
		return
	
	if not I.is_item_in_inventory('Translator'):
		E.run([
			"Marcianiu: I don't want it...",
			'...',
			'Marcianiu: But thanks for the offer.'
		])
	else:
		E.run([
			'Marcianiu: Ñiñiñiñiñi ñiñiñi ñiñiñiñiñiñi ñiñiñiñiñiñi'
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
