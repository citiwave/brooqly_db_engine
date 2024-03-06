module BrooqlyDbEngine
    class StoreList
        include Dynamoid::Document

        table name: :store_lists, key: :id, capacity_mode: :on_demand
        
        field :name, :string
        field :manager_id, :string
        field :stores, :array
    end
end