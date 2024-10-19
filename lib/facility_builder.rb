class FacilityBuilder
    attr_reader :facilities

    def initialize
        @facilities = []

        @co_dmv_data = DmvDataService.new.co_dmv_office_locations
        @ny_dmv_data = DmvDataService.new.ny_dmv_office_locations
        @mo_dmv_data = DmvDataService.new.mo_dmv_office_locations
    end

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