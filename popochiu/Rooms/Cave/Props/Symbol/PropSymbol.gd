tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	match $Sprite.frame:
		0:
			if C.player.script_name == 'Trapusinsiu':
				yield(E.run([
					'Player: I remember this symbol.',
					'Player: Marcianiu tought me how to activate it.',
					'Player: ñiñiñi ñiñi ñiñiñiñi...',
					'Player: ñiñi ñiñiñiñiñiñiñi ñiñiñiñi...',
					E.play_transition(TransitionLayer.PASS_DOWN_IN, 1.0),
					E.wait(2),
					E.play_transition(TransitionLayer.PASS_DOWN_OUT, 1.0),
					'Player: ñiñiñiñiñiñiñiñiñi.',
				]), 'completed')
				
				if Globals.state.SCEPTER_PUSHED:
					$Sprite.frame = 2
					room.get_prop('Hideout').open()
				else:
					E.run([
						'Player: What?',
						"Player: I'm sure this is the right thing to say...",
						"Player: But it didn't work...",
						'Player: Something must be missing.'
					])
			else:
				E.run([
					"Player: I don't know what to do here."
				])
		1:
			E.run([
				'Player: It is already activated...'
			])


# When the node is right clicked
func on_look() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	match $Sprite.frame:
		0:
			if C.player.script_name == 'Trapusinsiu':
				E.run([
					'Player: I remember this symbol.',
					'Player: Marcianiu tought me how to activate it.'
				])
			else:
				E.run(['Player: What does this mean...?'])
		1:
			E.run(['Player: Awesome!'])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	E.run(['Player: No can do.'])
