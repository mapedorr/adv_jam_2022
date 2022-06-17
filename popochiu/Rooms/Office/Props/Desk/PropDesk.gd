tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const DISPLACEMENT := Vector2(-100.0, -43.0)
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func displace() -> void:
	position += DISPLACEMENT
	room.get_prop('Note').position += DISPLACEMENT


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
	if Globals.state.PUSHED_DESKS.has(Globals.office):
		E.run(['Player: I think it is better here... near the door.'])
		return
	
	if C.player.script_name == 'Gonorrein':
		yield(E.run([
			'Player: Want me to push it?',
		]), 'completed')
		
		var choice: PopochiuDialogOption = yield(
			D.show_inline_dialog([
				'Yes',
				'No',
			]), 'completed'
		)
		
		match choice.id:
			'Opt1':
				if not I.is_item_in_inventory('Translator')\
				and Globals.office == Globals.TRANSLATOR_OFFICE:
					room.get_prop('Translator').enable(false)
				
				room.tween.interpolate_property(
					self, 'position',
					null, position + DISPLACEMENT,
					0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT
				)
				room.tween.interpolate_property(
					room.get_prop('Note'), 'position',
					null, room.get_prop('Note').position + DISPLACEMENT,
					0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT
				)
				room.tween.start()
				
				yield(room.tween, 'tween_all_completed')
				
				Globals.state.PUSHED_DESKS.append(Globals.office)
			
		G.done()
	else:
		E.run(['Player: Smells like ice cream.'])


# When the node is right clicked
func on_look() -> void:
	if C.player.script_name == 'Popsy':
		yield(E.run([
			C.face_clicked(),
			'Player: My desk.',
			'..',
			'Player: I like it so much that I decided to buy the same one for all of my offices.',
		]), 'completed')
	else:
		yield(E.run([
			C.face_clicked(),
			'Player: That desk rocks!'
		]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: To what end?',
	]), 'completed')
