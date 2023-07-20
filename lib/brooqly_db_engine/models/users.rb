module BrooqlyDbEngine
    class User  
        include Dynamoid::Document

        table name: :users, key: :id, capacity_mode: :on_demand
        
        field :personal_details,  :serialized
        field :user_data, :serialized
        field :user_id,  :string
        field :notifications, :array, of: :string
        field :friends, :array, of: :string
        field :location, :serialized

        def self.next_id
            s = User.count
            s.to_i+1
        end 
    end
end