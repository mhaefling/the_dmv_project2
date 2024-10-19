require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice})
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev})
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end

    it 'can initialize facilities, and vehicles' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_2).to be_an_instance_of(Facility)
      expect(@cruz).to be_an_instance_of(Vehicle)
      expect(@bolt).to be_an_instance_of(Vehicle)
      expect(@camaro).to be_an_instance_of(Vehicle)
      expect(@cruz.registration_date).to eq (nil)
      expect(@bolt.registration_date).to eq (nil)
      expect(@camaro.registration_date).to eq (nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end

    it 'can add new services' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(["Vehicle Registration"])
    end
  end

  describe '#register_vehicle' do
    it 'can register a vehicle, assign a plate type, collected registration fees' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@cruz.registration_date).to eq(Date.today)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.collected_fees).to eq(100)
    end

    it 'can register a vehicle(s), assign a plate type(s), collected registration fee(s)' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)
      expect(@camaro.registration_date).to eq(Date.today)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@bolt.registration_date).to eq(Date.today)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.collected_fees).to eq(325)
    end

    it 'can only register a vehicle if service is offered' do
      @facility_2.register_vehicle(@bolt)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  describe '#administer_written_test' do
    it 'confirms registrants initialize correctly' do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 16 )
      registrant_3 = Registrant.new('Tucker', 15 )
      expect(registrant_1).to be_an_instance_of(Registrant)
      expect(registrant_2).to be_an_instance_of(Registrant)
      expect(registrant_3).to be_an_instance_of(Registrant)
      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(registrant_1.permit?).to eq(true)
      expect(registrant_2.permit?).to eq(false)
      expect(registrant_3.permit?).to eq(false)
    end

    it 'confirms administer_written_test is not allowed if service not available' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      expect(@facility_1.administer_written_test(registrant_1)).to eq(false)
      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'confirms after service is added facility is able to issue written test' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      expect(@facility_1.administer_written_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end
  end

  describe '#earn_permit' do
    it 'confirms registrant 2 was initialized with no permit' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      expect(registrant_2.age).to eq(16)
      expect(registrant_2.permit?).to eq(false)
      expect(@facility_1.administer_written_test(registrant_2)).to eq(false)
    end

    it 'confirms registrant 2 earned permit and is the correct age to take written test.' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      registrant_2.earn_permit
      expect(registrant_2.permit?).to eq(true)
      expect(@facility_1.administer_written_test(registrant_2)).to eq(true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    end
    
    it 'confirms registrant 3 initialized with no permit at the age of 15' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      expect(registrant_3.age).to eq(15)
      expect(registrant_3.permit?).to eq(false)
      expect(@facility_1.administer_written_test(registrant_3)).to eq(false)
    end

    it 'confirms registrant 2 cannot take written test at age of 15' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      registrant_3.earn_permit
      expect(@facility_1.administer_written_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe '#administer_road_test' do
    it 'confirms facility is unable to do road test with out the service' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      registrant_3.earn_permit
      expect(@facility_1.administer_road_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'confirms that facility has the service, and registrant meets road test requirements' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      expect(@facility_1.administer_road_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'confirms facility has service, and after road test, license is issued' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(registrant_1)
      registrant_2.earn_permit
      @facility_1.administer_written_test(registrant_2)
      expect(@facility_1.add_service('Road Test')).to eq(["Written Test", "Road Test"])
      expect(@facility_1.administer_road_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
      expect(@facility_1.administer_road_test(registrant_2)).to eq(true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end
  end

  describe '#renew_drivers_license' do
    it 'confirms that facility cannot renew license with out the service' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      @facility_1.administer_written_test(registrant_1)
      registrant_2.earn_permit
      @facility_1.administer_written_test(registrant_2)
      @facility_1.administer_road_test(registrant_1)
      @facility_1.administer_road_test(registrant_2)
      expect(@facility_1.renew_drivers_license(registrant_1)).to eq(false)
      expect(@facility_1.renew_drivers_license(registrant_2)).to eq(false)
    end

    it 'confirms that facality has the renew license service' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      expect(@facility_1.add_service('Renew License')).to eq(["Written Test", "Road Test", "Renew License"])
    end

    it 'confirms that registrant 1 is able to renew license' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Renew License')
      @facility_1.administer_written_test(registrant_1)
      registrant_2.earn_permit
      @facility_1.administer_written_test(registrant_2)
      @facility_1.administer_road_test(registrant_1)
      @facility_1.administer_road_test(registrant_2)
      expect(@facility_1.renew_drivers_license(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
      expect(@facility_1.renew_drivers_license(registrant_2)).to eq(true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>true})
    end

    it 'confirms that registrant without road test or written license cannot be renewed' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16)
      registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Renew License')
      expect(@facility_1.renew_drivers_license(registrant_3)).to eq(false)
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end
end

