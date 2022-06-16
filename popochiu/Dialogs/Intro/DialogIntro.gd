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
				'Goddiu: Yes, I am.',
				'Goddiu: And those are Popsy and Trapusinsiu',
				'Goddiu: ' + Utils.say_in_popochiu('My epatius', 'brothers')
			]), 'completed')
			
			opt.turn_off()
		'Opt2':
			yield(E.run([
				'Goddiu: Chiquinín is missing!!!',
				'Popsy(sad): $$$$$$$$!',
				'Trapusinsiu(sad): ########!',
				'Goddiu: Last night I heard some noises.',
				"Goddiu: And this morning, after I woke up, I didn't see him anywhere.",
				"Goddiu: I asked Popsy and Trapusinsiu... but they don't know where he is either.",
				'Popsy: $$$ $$$$',
				'Trapusinsiu: ### #####',
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt3').turn_on()
		'Opt3':
			yield(E.run([
				'Goddiu: ' + Utils.say_in_popochiu('He is our younger epatí.', 'brother'),
				"Goddiu: I'm sure he's very scared and crying.",
				'Goddiu: And worst of all...',
				'...',
				'Goddiu: HE MAY EVEN HAVE POOPED IN HIS PANTS!!!',
				'Popsy(sad): $$$$$$$$$!!!',
				'Trapusinsiu(sad): ########!!!',
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt4').turn_on()
		'Opt4':
			yield(E.run([
				'Goddiu: Yes please!',
				"Goddiu: Don't know where is Gonorreín either...",
				'Goddiu: But he can take care of himself.'
			]), 'completed')
			
			opt.turn_off()
			get_option('Opt5').turn_on()
		'Opt5':
			yield(E.run([
				'Goddiu: Of course!',
				"Goddiu(happy): Let's go find Chiquininín!!!",
				'Popsy(happy): $$$$$$!!!!!',
				'Trapusinsiu(happy): #######!!!!'
			]), 'completed')
			
			C.player.can_move = true
			D.finish_dialog()
			return
	
	_show_options()
