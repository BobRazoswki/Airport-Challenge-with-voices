#require 'lib/planes.rb'
require './lib/weather'
#['planes', 'weather'].each { |r| require r }
class Airport

include Weather

DEFAULT_CAPACITY = 40

	def initialize(capacity: DEFAULT_CAPACITY)
		@capacity = DEFAULT_CAPACITY
		@airport_name = say_(airport_name)
	end

	def hangar
		@hangar ||= []
	end

	def land(plane)
		raise `say -v Kathy  Flight number #{plane.flight_number} the weather is too stormy to let you land at #{airport_name}` if check_weather 
		raise `say -v Kathy The #{airport_name} is currently full, please would you mind to do some turn in the air and be patient` if full
		raise `say -v Kathy Hell god, are you trying to fool #{airport_name}, say it, say it !`  if already_in_the_hangar(plane)
		hangar << plane
		plane.landed
	end

	def already_in_the_hangar(plane)
		hangar.include?(plane)
	end

	def take_off(plane)
		raise `say -v Kathy Flight number #{plane.flight_number} the weather is too stormy to let you take off from #{airport_name}` if check_weather
		hangar.pop
		plane.in_the_air
		#hangar.delete(plane.in_the_air)
	end

	def all_together(hangar)
		raise `say -v Kathy Bataillon 007 the airport #{airport_name} is glad to have you for the Grand Final, but unfortunatelly there is a storm operating outside, please don't go` if check_weather
		hangar.select {|plane| plane.in_the_air }
		hangar.clear
	end

	def airplane_count
		hangar.count
	end

	def full
		airplane_count == DEFAULT_CAPACITY
	end

private

def airport_name
	["Orly", "Charles de gaulle", "Charleroi", "bobby's airport"].sample
end

def say_(airport_name)
	`say -v Vicki The airport #{airport_name} is operational and can drive the planes`
	airport_name
end

end
