
# The VehicleFactory class, pulls API data and creates vehicle obsjects from that data.
class VehicleFactory
    attr_reader :vehicle_instances

# The VehicleFactory stores all the objects its created in an array called vehicle_instances
    def initialize
        @vehicle_instances = []
    end

=begin
    Method: create_vehicles takes a single argument which is a variable linking to the API Data
    It then uses the enumerator .each to iterate over every hash contained in that array, pulling out specific hash keys
    It then takes the values of those keys and creates its own hash called "vehicle_details"
    which it feeds as the argument to the Vehicle class to create new instances or objects of the vehicle
=end
    def create_vehicles(data_set)
        data_set.each do |vehicle|
            vehicle_details = {
                vin: vehicle[:"vin_1_10"],
                year: vehicle[:"model_year"],
                make: vehicle[:"make"],
                model: vehicle[:"model"],
                engine: :ev,
                registration_date: nil,
                plate_type: :ev
            }
            @vehicle_instances << Vehicle.new(vehicle_details)
        end
        return @vehicle_instances
    end

# Method: most_mopular_model used the enumerator .map to create a list of all the different models in the wa ev registration api.
# It then uses the method .tally to count the number of 
    def most_popular_model
        vehicle_models = @vehicle_instances.map do |vehicle|
            vehicle.model
        end
        tally_by_model = vehicle_models.tally
        most_popular = tally_by_model.max_by do |key, value|
            value
        end.first
    end

    def count_model_year(vehicle_year)
        model_year = @vehicle_instances.map do |vehicle|
            vehicle.year.to_i
        end
        total = model_year.count(vehicle_year)
    end
end