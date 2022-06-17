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
				'Popsy: My name is Popsy.',
				"Popsy: I'm glad you can understand me now."
			]), 'completed')
		'Opt2':
			yield(E.run([
				'Popsy: I have a great sense of smell.',
				"Popsy: And I am pretty sure last night I smelled Roberto's scent.",
				'Popsy: It is a really disgusting sensation.'
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt3').turn_on()
		'Opt3':
			yield(E.run([
				'Popsy: Of course I want.',
				'Popsy: I can not imagine what he might be suffering in hands of Roberto.',
				"Popsy: And he's probably already soiled his diapers."
			]), 'completed')
			
			Globals.playable_popochius.append('Popsy')
			C.get_character('Popsy').can_move = true
			D.finish_dialog()
			return
	
	_show_options()
