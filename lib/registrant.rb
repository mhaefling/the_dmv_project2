class Registrant

# The registrant class stores the attributes of each registrant created.
    attr_reader :name,
                :age,
                :permit,
                :license_data

# Each registrant should be created with a name and age, and possibly a permit. I
# If no value for permit is provided its assumed that the registrant doesn't have a permit.
    def initialize(name, age, permit = false)
        @name = name
        @age = age
        @permit = permit
        @license_data = {
            written: false,
            license: false,
            renewed: false
        }
    end

# Method: permit? checks the permit attribute and returns true or false.
    def permit?
        @permit
    end

# Method: earn_permit will change the default value of permit from false to true.
    def earn_permit
        @permit = true
    end

# Method: take_written_test is called on by the facility class method "administer_written_test".  
# It then confirms if the registrant has a permit and if the registrant is at least 16 years of age or older.
# If both are true it changes the key value for :written to true.  If either are false it will not change the key value for :written and continues to return false.
    def take_written_test
        if @permit == true && @age >= 16
            @license_data[:written] = true
        else
            false
        end
    end

# Method: take_road_test is called on by the facility class method "administer_road_test"
# It then confirms if the registrant has already taken the written test, and if true changes the key value for :license to true
# If the registrant has not taken the written test, it leaves the key value for :license false and returns false.
    def take_road_test
        if @license_data[:written] == true
            @license_data[:license] = true
        else
            false
        end
    end

# Method: renewed_license is called on by the facility class method "renew_drivers_license"
# It checks to confirm that the registrant currently has a license and if true changes the value of key :renewed to true
# If the registrant doesn't have a license it leaves the key value of :renewed false and returns false.
    def renewed_license
        if @license_data[:license] == true
            @license_data[:renewed] = true
        else
            false
        end
    end
end