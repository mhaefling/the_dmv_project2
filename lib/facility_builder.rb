class FacilityBuilder
    def initialize
        @co_dmvs = []
    def

    def create_facilities(data_set)
        data_set.each do |dmv|
        facility_details = {
            name: dmv[:"dmv_office"],
            address: "#{dmv[:"address_li"]} #{dmv[:"address_1"]} #{dmv[:"city"]} #{dmv[:"state"]} #{dmv[:"zip"]}",
            phone: dmv[:"phone"]
        }
        @co_dmvs << Facility.new(facility_details)
      end
      require 'pry'; binding.pry
    end
end