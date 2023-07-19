module BrooqlyDbEngine
    class User  
        include Dynamoid::Document

        table name: :users, key: :id, capacity_mode: :on_demand
        
        field :profile_details,  :serialized
        field :user_data, :serialized

        def self.next_id
            s = User.count
            s.to_i+1
        end 
    end
end