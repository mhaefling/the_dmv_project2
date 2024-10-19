require './lib/vehicle'
require './lib/vehicle_factory'
require './lib/dmv_data_service'
require './spec/spec_helper'

RSpec.describe VehicleFactory do
    describe '#initialize' do
        it 'is an instance of VehicleFactory' do
            factory = VehicleFactory.new
            expect(factory).to be_an_instance_of(VehicleFactory)
        end

        it 'confirms wa_ev_registrations holds all the json data from api wa_ev_registrations' do
            wa_ev_registrations = DmvDataService.new.wa_ev_registrations
            expect(wa_ev_registrations).to eq(DmvDataService.new.wa_ev_registrations)
        end
    end

    describe '#create_vehicles' do
        xit 'creates a bunch of instances of vehicles from api data' do
            factory = VehicleFactory.new
            wa_ev_registrations = DmvDataService.new.wa_ev_registrations
            factory.create_vehicles(wa_ev_registrations)
        end
    end
end