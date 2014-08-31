class Plane

attr_accessor :flight_number

	def initialize
		in_the_air
		@flight_number = say_the_name(random_flight_names)
	end

	def flying?
		@flying
	end

	def landed
		@flying = false
		self
	end

	def in_the_air
		@flying = true
		self
	end

	private

	def random_flight_names
		 rand.to_s[2..8]
	end

	def say_the_name(random_flight_names)
		`say -v Kathy "The flight number #{random_flight_names} has been detected by our technology"`
		random_flight_names
	end


end