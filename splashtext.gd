extends Label
var tilt = 0.12

func _ready() -> void:
	_tiltchange()
	var splash = randi_range(1, 64)
	match splash:
		1:
			self.text = "First we Hack, then we Slash!"
		2:
			self.text = "Now with 30% more unicorns!"
		2:
			self.text = "With Losers that look like your parents!"
		3:
			self.text = "Hack & Slash: Also try Minecraft!"
		4:
			self.text = "Hack & Slash: For the worthy!"
		5:
			self.text = "Now with high cortisol!"
		6:
			self.text = "Wasting coding time on splash text!"
		7:
			self.text = "Have a break, have a butter toast!"
		8:
			self.text = "Even more Zach R. Latta!"
		9:
			self.text = "Punching toddlers simulator!"
		10:
			self.text = "My name is market pliers!"
		11:
			self.text = "Voting this a 10 is mandatory to exist!"
		12:
			self.text = "Baby shoes for sale: Never born!"
		13:
			self.text = "Virtual grass-touching technology!"
		14:
			self.text = "Even less Fitness Gram Pacer tests!"
		15:
			self.text = "A shrimp fried this!"
		16:
			self.text = "Half Life? Why not the full one?"
		17:
			self.text = "My divinity is past infinity!"
		18:
			self.text = "We love casting spells! Shadow government!"
		19:
			self.text = "Have a break, have a butter toast!"
		20:
			self.text = "Because you needed the payout!"
		21:
			self.text = "Salad dressing? Well then, don't look!"
		22:
			self.text = "Locust was a little devil thing!"
		23:
			self.text = "Don't tell me how many calories I need!"
		24:
			self.text = "The clock strikes twelve - midnight arrives!"
		25:
			self.text = "Licensing the Giant Enemy Spider!"
		26:
			self.text = "Better than Portal 3!"
		27:
			self.text = "YOU. ARE. A. TOY!"
		28:
			self.text = "300 Locust Hordes? for only 2 pounds?"
		29:
			self.text = "Caseoh ate my code!"
		30:
			self.text = "Honey, where are my pants?"
		31: 
			self.text = "500 Permaperks..."
		32: 
			self.text = "H&N Perks gives you deals on the food you love!"
		33: 
			self.text = "Verbalase spent 50K on this!"
		34: 
			self.text = "Block. Parry. Dodge."
		35: 
			self.text = "I'm the slim Slasher, yes I'm the real Slasher!"
		36: 
			self.text = "Sea sells she shells by the shore sea!"
		37: 
			self.text = "Now with the Moon Men song during dialogue!"
		38: 
			self.text = "DJDUWKD UXOHV!"
		39: 
			self.text = "Better than the Evo Pekka meta!"
		40: 
			self.text = "Solos the gorilla!"
		41: 
			self.text = "With Literature Club poem reviews!"
		42: 
			self.text = "Rightside up in Australia!"
		43: 
			self.text = "Inspired by Hackclub Shower Simulator!"
		44: 
			self.text = "Splash text was a worthy addition!"
		45: 
			self.text = "Now with twice the Thanksgiving time turkeys!"
		46: 
			self.text = "Postponing knee surgery since 1983!"
		46: 
			self.text = "The game she tells you not to worry about!"
		47: 
			self.text = "Kilometers! The white two!"
		48: 
			self.text = "Not sponsored by NordVPN!"
		49: 
			self.text = "All three seasons of a manic episode!"
		50: 
			self.text = "Hackery and Slashery, all of the time!"
		51: 
			self.text = "Lactose intolerant people aren't real!"
		52: 
			self.text = "Spencer hates Elvis!"
		53: 
			self.text = "Hack and Slash: You da real slash!"
		54: 
			self.text = "Praise the almighty Monicookie!"
		55: 
			self.text = "Love every neighbor - except Grace!"
		56: 
			self.text = "A horse walked into this bar!"
		56: 
			self.text = "You can't stand this bizarre adventure!"
		57: 
			self.text = "Big pharma has him on a leash!"
		58: 
			self.text = "Will Dylan ever finish his passion project?"
		59: 
			self.text = "Chiming in with closed doors!"
		60: 
			self.text = "Anybody else hear those ominous bells? No?"
		61: 
			self.text = "This, prison? To contain me?"
		62: 
			self.text = "Now with 2000 more acres of Backrooms!"
		63: 
			self.text = "Now with admission into Agartha!"
		64: 
			self.text = "Flavortown Flavortown Flavortown!"


func _tiltchange() -> void:
	var t1 = create_tween()
	t1.tween_property(self, "tilt", -0.12, 1.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await t1.finished
	
	var t2 = create_tween()
	t2.tween_property(self, "tilt", 0.12, 1.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	await t2.finished
	
	_tiltchange()

func _process(_delta: float) -> void:
	self.rotation_degrees += tilt
