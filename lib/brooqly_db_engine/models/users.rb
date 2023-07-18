module BrooqlyDbEngine
    class User  
        include Dynamoid::Document

        table name: :users, key: :id, capacity_mode: :on_demand
        
        field name :profile_details :set, of: { serialized: { serializer: JSON } }
        field name :user_data :set, of: { serialized: { serializer: JSON } }
    end
end