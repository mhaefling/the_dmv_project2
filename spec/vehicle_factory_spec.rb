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
    end

    describe '#create_vehicles' do
        it 'create an array of vehicle objects/instances' do
            factory = VehicleFactory.new
            wa_ev_registrations = DmvDataService.new.wa_ev_registrations
            factory.create_vehicles(wa_ev_registrations)
            expect(factory.vehicle_instances).to be_an(Array)
            expect(factory.vehicle_instances.sample).to be_an(Vehicle)
        end

        it 'checks that vehicles have the correct attributes' do
            factory = VehicleFactory.new
            wa_ev_registrations = DmvDataService.new.wa_ev_registrations
            factory.create_vehicles(wa_ev_registrations)
            expect(factory.vehicle_instances.sample.engine).to be_an(Symbol)
            expect(factory.vehicle_instances.sample.make).to be_an(String)
            expect(factory.vehicle_instances.sample.model).to be_an(String)
            expect(factory.vehicle_instances.sample.plate_type).to be_an(Symbol)
            expect(factory.vehicle_instances.sample.registration_date).to eq(nil)
            expect(factory.vehicle_instances.sample.vin).to be_an(String)
            expect(factory.vehicle_instances.sample.year).to be_an(String)
        end
    end
end