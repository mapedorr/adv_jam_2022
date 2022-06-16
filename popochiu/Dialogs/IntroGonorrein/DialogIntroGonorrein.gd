tool
extends PopochiuDialog


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func start() -> void:
	# One can put here something to excecute before showing the dialog options.
	# E.g. Make the PC to look at the character which it will talk to, walk to
	# it, and say something (or make the character say something)
	
	# This makes the options to appear
	.start()


func option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		'Opt1':
			yield(E.run([
				'Gonorrein: It is a game about about a small fox on a big adventure.',
				'Gonorrein: You have to find three keys to free a soul.',
				'Gonorrein: And there are ferocious monsters that block your way.',
				'Player: What is a fox?',
				'Gonorrein: I have told you several times %s.' % C.player.script_name
			]), 'completed')
			
			opt.turn_off()
		'Opt2':
			yield(E.run([
				"Gonorrein: Isn't he on the terrace?",
				'Player: Nope.',
				"Gonorrein: Isn't he in the tub? He likes being there a lot.",
				'Player: Nope.',
				"Gonorrein: Isn't he under the bed?",
				'Player: Nope.',
				'Gonorrein: F@@k! F@@k! F@@k!',
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt3').turn_on()
		'Opt3':
			yield(E.run([
				'Gonorrein: Of course!',
				'Gonorrein: I hope this has nothing to do with Roberto.',
				'Player(sad): ' + Utils.say_in_popochiu('Ayyy dooooooooooooooo!', 'cries'),
				'Gonorrein: Stop crying %s.' % C.player.script_name,
				"Gonorrein: You'll make my cry too..."
			]), 'completed')
			
			Globals.playable_popochius.append('Gonorrein')
			C.get_character('Gonorrein').can_move = true
			
			opt.turn_off()
			get_option('Opt4').turn_on()
		'Opt4':
			yield(E.run([
				'Gonorrein: Here, I found this over the shelf when I was looking those weird toys.'
			]), 'completed')
			
			opt.turn_off()
			
			Globals.found_pages[Globals.PAGE_CODES.OTHER_CREATURES] = true
			Globals.show_book(Globals.PAGE_CODES.OTHER_CREATURES)
			yield(Globals, 'book_closed')
			
			if get_option('Opt5').used:
				D.finish_dialog()
				return
		'Opt5':
			yield(E.run([
				'Gonorrein: Oh! I had not seen it...',
				E.current_room.get_prop('Page').disable(),
				'Gonorrein: Here you have.',
				'Gonorrein: It seems that someone was doing bad things while we were sleeping.',
			]), 'completed')
			
			opt.turn_off()
			
			Globals.found_pages[Globals.PAGE_CODES.POPSY_TRAPUSINSIU] = true
			Globals.show_book(Globals.PAGE_CODES.POPSY_TRAPUSINSIU)
			yield(Globals, 'book_closed')
			
			if get_option('Opt4').used:
				D.finish_dialog()
				return
	
	_show_options()
