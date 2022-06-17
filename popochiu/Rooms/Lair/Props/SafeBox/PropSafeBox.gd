tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const DISPLACEMENT := Vector2(-115.0, 10.0)
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Globals.state.PUSHED_SAFEBOX:
		position += DISPLACEMENT


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	if Globals.state.PUSHED_SAFEBOX:
		E.run(["Player: Is where it should be."])
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
	]), 'completed')
	
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
				Globals.state.PUSHED_SAFEBOX = true
				room.get_prop('Cover').enable(false)
				
				room.tween.interpolate_property(
					self, 'position',
					null, position + DISPLACEMENT,
					1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT
				)
				room.tween.start()
				
				yield(room.tween, 'tween_all_completed')
			
		G.done()
	else:
		E.run([
			'Player: We need a code to open this!'
		])


# When the node is right clicked
func on_look() -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: The safebox looks super safe and heavy.'
	]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: That... will... not work.'
	]), 'completed')
