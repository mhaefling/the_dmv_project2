require 'rspec'
require './lib/vehicle'
require './lib/vehicle_factory'
require './lib/dmv_data_service'
require './spec/spec_helper'

RSpec.describe FacilityBuilder do
    before(:each) do
        @dds = DmvDataService.new
      end

    describe '#initialize' do
        it "is an instance of facilitybuilder" do
            build_facilities = FacilityBuilder.new
            expect(build_facilities).to be_an_instance_of(FacilityBuilder)
        end
    end

    describe '#create_facilities' do
        it "can determine which dmv data to use co" do
            build_facilities = FacilityBuilder.new
            co_dmvs = @dds.co_dmv_office_locations
            build_facilities.create_facilities(co_dmvs)
            expect(build_facilities.facilities.sample.address).to include("CO")
        end

        it "can determine which dmv data to use ny" do
            build_facilities = FacilityBuilder.new
            new_york_facilities = @dds.ny_dmv_office_locations
            build_facilities.create_facilities(new_york_facilities)
            expect(build_facilities.facilities.sample.address).to include("NY")
        end

        it 'can determine which dmv data to use mo' do
            build_facilities = FacilityBuilder.new
            missouri_facilities = @dds.mo_dmv_office_locations
            build_facilities.create_facilities(missouri_facilities)
            expect(build_facilities.facilities.sample.address).to include("MO")
        end

        it 'includes the right number of facilities co' do
            build_facilities = FacilityBuilder.new
            co_dmvs = @dds.co_dmv_office_locations
            build_facilities.create_facilities(co_dmvs)
            expect(build_facilities.facilities.count).to eq(@dds.co_dmv_office_locations.count)
        end

        it 'includes the right number of facilities ny' do
            build_facilities = FacilityBuilder.new
            new_york_facilities = @dds.ny_dmv_office_locations
            build_facilities.create_facilities(new_york_facilities)
            expect(build_facilities.facilities.count).to eq(@dds.ny_dmv_office_locations.count)
        end

        it 'includes the right number of facilities mo' do
            build_facilities = FacilityBuilder.new
            missouri_facilities = @dds.mo_dmv_office_locations
            build_facilities.create_facilities(missouri_facilities)
            expect(build_facilities.facilities.count).to eq(@dds.mo_dmv_office_locations.count)
        end

        it 'has all the write data types co' do
            build_facilities = FacilityBuilder.new
            co_dmvs = @dds.co_dmv_office_locations
            build_facilities.create_facilities(co_dmvs)
            expect(build_facilities.facilities.sample.)
        end
    end
end