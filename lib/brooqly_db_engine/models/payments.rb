module BrooqlyDbEngine
    class Payment  
        include Dynamoid::Document

        table name: :payments, key: :id, capacity_mode: :on_demand

        field :store_id, :string
        field :treats_id, :array, of: :string
        field :amount, :string
        field :status, :string
        
        global_secondary_index hash_key: :store_id
    end
end