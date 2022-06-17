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
				'Trapusinsiu: Trapusinsiu is my name.',
				"Trapusinsiu: Why you didn't talk to us earlier.",
				"Trapusinsiu: Didn't you understand us?",
			]), 'completed')
		'Opt2':
			yield(E.run([
				'Trapusinsiu: Well... I heard something.',
				"Trapusinsiu: It was Roberto's voice.",
				'Trapusinsiu: No doubt of it.',
				'Goddiu: Trapusinsiu is amazing imitating voices and sounds.'
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt3').turn_on()
		'Opt3':
			yield(E.run([
				'Trapusinsiu: %s.' % Utils.say_in_popochiu('Ti! ti! ti!', 'Yes! yes! yes!'),
				'Trapusinsiu: I can not move by myself, but I will try to help somehow.',
				"Trapusinsiu: Anything to bring Chiquininín home."
			]), 'completed')
			
			Globals.playable_popochius.append('Trapusinsiu')
			D.finish_dialog()
			return
	
	_show_options()
