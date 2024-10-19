require 'rspec'
require './spec/spec_helper'

describe 'FacilityBuilder' do
    describe '#create_facilities' do
        it "creates all of the co dmv's" do
            facilities = FacilityBuilder.new
            co_dmvs = DmvDataService.new.co_dmv_office_locations
            facilities.create_facilities(co_dmvs)
        end
    end
end