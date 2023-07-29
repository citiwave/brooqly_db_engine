module BrooqlyDbEngine
    class Owner  
        include Dynamoid::Document

        table name: :owners, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :permissions,  :serialized
        field :account,  :serialized

        global_secondary_index hash_key: :user_id
  
    end
end