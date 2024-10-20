
# The FacilityBuilder class, pulls API data and creates facility obsjects from that data.
class FacilityBuilder
    attr_reader :facilities

# The FacilityBuilder stores all the objects its created in an array called facilities

    def initialize
        @facilities = []

        @co_dmv_data = DmvDataService.new.co_dmv_office_locations
        @ny_dmv_data = DmvDataService.new.ny_dmv_office_locations
        @mo_dmv_data = DmvDataService.new.mo_dmv_office_locations
    end

=begin
    Method: create_facilities accepts a single variable argument. That variable contains a link that points to a json file that
    contains an array with many different hashes with different dmv's location data.
    It then uses an condition statement to compare the argument provided to the instances variables to confirm which states
    dmv api data its using and proceeds to use the enumerator .each to go through each hash pulling out specific values of hash keys
    depending on which state's dmv its using.
=end

    def create_facilities(data_set)

        if data_set == @co_dmv_data
            data_set.each do |dmv|
                facility_details = {
                    name: dmv[:"dmv_office"],
                    address: "#{dmv[:"address_li"]} #{dmv[:"address_1"]} #{dmv[:"city"]} #{dmv[:"state"]} #{dmv[:"zip"]}",
                    phone: dmv[:"phone"]
                }
                facilities << Facility.new(facility_details)
            end

        elsif data_set == @ny_dmv_data
            data_set.each do |dmv|
                facility_details = {
                    name: dmv[:"office_name"],
                    address: "#{dmv[:"street_address_line_1"]} #{dmv[:"city"]} #{dmv[:"state"]} #{dmv[:"zip_code"]}",
                    phone: dmv[:"public_phone_number"]
                }
                facilities << Facility.new(facility_details)
            end
        
        elsif data_set == @mo_dmv_data
            data_set.each do |dmv|
                facility_details = {
                    name: dmv[:"name"],
                    address: "#{dmv[:"address1"]} #{dmv[:"city"]} #{dmv[:"state"]} #{dmv[:"zipcode"]}",
                    phone: dmv[:"phone"]
                }
                facilities << Facility.new(facility_details)
            end
        end 
    end
end