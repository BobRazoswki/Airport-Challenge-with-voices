['airport', 'weather'].each { |r| require r }

shared_examples 'Planes are subject to mother nature..' do

	let(:airport)      { Airport.new   }
	let(:plane)        { double :plane, flying?: true, check_weather: true, landed: true, in_the_air: nil  }
	let(:plane_sunny)  { double :plane, flying?: true, check_weather: true, landed: true, in_the_air: nil  }
	let(:plane_stormy) { double :plane, flying?: true, check_weather: false, landed: true, in_the_air: nil }
	let(:plane_landed) { double :plane, landed: true, check_weather: false, in_the_air: nil, flying?: false}
	let(:plane_fly)    { double :plane, flying?: false, check_weather: true, landed: true, in_the_air: nil }
	let(:all_together_){ double :plane, check_weather: false, select: self, clear: self, landed: false     }
	let(:plane_sample) { double :plane, landed: true, flying?: false   }

	
	before(:each) do
		allow(airport).to receive(:check_weather).and_return(false)
	end

	context 'An airport' do

		it 'can land a plane' do
			airport.land(plane)
			expect(airport.hangar).to eq ([plane])
		end

		it 'can take off a plane' do
			airport.land(plane)
			expect(airport.airplane_count).to eq 1
			airport.take_off(plane)
			expect(airport.airplane_count).to eq 0
		end
		
		it 'know how many plane he has in the hangar' do
			expect(airport.airplane_count).to eq 0
			airport.land(plane)
			expect(airport.airplane_count).to eq 1
		end

		it 'raise an error when it is full' do
			Airport::DEFAULT_CAPACITY.times { airport.land(double :plane, landed: true) }
			expect{ airport.land(double :plane, landed: true) }.to raise_error(RuntimeError)
		end

		it 'allows planes to land if it is sunny' do
			allow(airport).to receive(:check_weather).with(1..20).and_return(true)
			airport.land(plane_sunny)
			expect(airport.hangar).to include(plane_sunny)
		end

		it 'raise an error if it is stormy' do
			allow(airport).to receive(:check_weather).and_return(true)
			expect{airport.land(plane_stormy)}.to raise_error(RuntimeError)
		end

		it 'cannot take off if it is stormy' do
			allow(airport).to receive(:check_weather).and_return(true)
			expect{airport.take_off(plane)}.to raise_error(RuntimeError)
		end

	end


	context 'Grand final - All planes ' do

		it 'can land together' do
			Airport::DEFAULT_CAPACITY.times { airport.land(double :plane, landed: true) }
			expect(airport.airplane_count).to eq 40
  	end

  	it 'can take off together' do
			airport.all_together(airport.hangar)
			expect(airport.airplane_count).to eq 0
  	end

		it 'can change there statut to in_the_air' do
			#Airport::DEFAULT_CAPACITY.times { airport.land(plane_fly) }
			airport.all_together(airport.hangar)
			expect(plane_fly).not_to be_flying
  	end

  	it 'can change there statut to landed' do
			Airport::DEFAULT_CAPACITY.times { airport.land(double :plane, landed: true) }
			expect(plane_sample).not_to be_flying
  	end

  	it 'raise error if the weather is bad ' do
  		allow(airport).to receive(:check_weather).and_return(true)
  		expect{ airport.all_together(all_together_) }.to raise_error(RuntimeError)
  	end

	end


end

