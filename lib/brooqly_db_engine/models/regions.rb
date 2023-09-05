module BrooqlyDbEngine
    class Region  
        include Dynamoid::Document

        table name: :regions, key: :id, capacity_mode: :on_demand
        
        field :country, :string 
        field :regions, :array, of: :string

        def category
        end
    end
end