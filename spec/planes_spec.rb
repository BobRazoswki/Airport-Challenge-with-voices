['planes', 'airport_spec'].each { |r| require r }

describe 'A plane' do

	it_behaves_like 'Planes are subject to mother nature..'

	let(:plane) { Plane.new }
	let(:plane_landed) { double :plane, landed: true, check_weather: false, in_the_air: nil, flying?: false  }


	it 'is in_the_air when it is initialized' do
		expect(plane).to be_flying
	end

	it 'can change his statut to landed' do
		expect(plane.landed).not_to be_flying
	end

	it 'can change his statut to in_the_air' do
		expect(plane.in_the_air).to be_flying
	end

	it 'can be tested with his double for landed' do
		allow(plane_landed).to receive(:landed).and_return(false)
		airport.take_off(plane_landed)
		airport.land(plane_landed)
		expect(plane_landed).not_to be_flying
	end

	it 'can be tested with his double for in the air' do
		allow(airport).to receive(:landed).and_return(false)
		airport.take_off(plane)
		expect(plane).to be_flying
	end

	it 'has a new name when it is created' do
		allow(double :plane).to receive(:initialize).and_return(say_the_name)
	end

		
end