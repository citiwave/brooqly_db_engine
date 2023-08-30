module BrooqlyDbEngine
    class Location  
        include Dynamoid::Document

        table name: :locations, key: :id, capacity_mode: :on_demand
        
        field :address, :string 
        field :city, :string 
        field :postal_code, :string 
        field :country, :string 

        field :lat, :number 
        field :lng, :number 
        field :maps_url, :string 
        field :place_id, :string 

        # global_secondary_index hash_key: :location_id
        def category
        end
    end
end