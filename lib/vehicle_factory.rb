class VehicleFactory
    attr_reader :vehicle_instances

    def initialize
        @vehicle_instances = []
    end

    def create_vehicles(data_set)
        data_set.each do |vehicle|
            vehicle_details = {
                vin: vehicle[:"vin_1_10"],
                year: vehicle[:"model_year"],
                make: vehicle[:"make"],
                model: vehicle[:"model"],
                engine: :ev,
                registration_date: vehicle[:"transactoin_date"],
                plate_type: :ev
            }
            @vehicle_instances << Vehicle.new(vehicle_details)
        end
    end
end