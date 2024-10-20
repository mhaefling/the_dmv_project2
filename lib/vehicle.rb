require 'date'

# The vehicle class stores the attributes of each vehicle created.
class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :registration_date,
              :plate_type

# Each vehicle should or will eventually have assigned the below attributes.
  def initialize(vehicle_details)
    @vin = vehicle_details[:vin]
    @year = vehicle_details[:year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine]
    @registration_date = vehicle_details[:registration_date]
    @plate_type = vehicle_details[:plate_type]
  end

  # Method: antique? will confirm if the car is an antique by taking the current year and subtracting the year of the vehicle 
  # to confirm if its more than 25 years old.
  def antique?
    Date.today.year - @year > 25
  end

  # Method: electric_vehicle? checks the value of the attribute engine to confirm if its "":ev" (Electric Vehicle)
  def electric_vehicle?
    @engine == :ev
  end

=begin
  Method: reg_plate_type is called on by the facility class when registering a vehicle to determine what type of plate should be
  assigned to the vehicle, by checking the vehicles age attribute via the antique? method, the vehicles engine type via the 
  electric_vehicle? method, if either do not apply the plate is assigned to ":regular"
=end

  def reg_plate_type
    if antique?
      @plate_type = :antique
    elsif electric_vehicle?
      @plate_type = :ev
    else
      @plate_type = :regular
    end
  end

# Method reg_plate assigns the date of when the vehicle instance was created or the day the facility class registered the vehicle
  def reg_date
    @registration_date = Date.today
  end
end
