module BrooqlyDbEngine
    class Store  
        include Dynamoid::Document

        table name: :stores, key: :id, capacity_mode: :on_demand
        
        field :address, :serialized 
        field :contact, :serialized
        field :data,  :serialized
        field :financial,  :serialized
        field :items, :serialized
        field :presence,  :serialized
        field :owners, :array, of: :integer

        def self.next_id
            s = Store.count
            s.to_i+1
        end
    end
end