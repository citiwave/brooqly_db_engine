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

        global_secondary_index hash_key: :user_id
    end
end