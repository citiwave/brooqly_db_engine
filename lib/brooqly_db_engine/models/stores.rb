module BrooqlyDbEngine
    class Store  
        include Dynamoid::Document

        table name: :stores, key: :id, capacity_mode: :on_demand
        
        field :address, :serialized 
        field :contact, :serialized
        field :data,  :serialized
        field :financial,  :serialized
        field :items, :serialized
        field :bpresence,  :serialized
        field :store_id,  :string
        field :owners, :array, of: :integer

        global_secondary_index hash_key: :store_id
        
        def name=(name)
            self.bpresence = {name: name}
        end
        def name
            self.bpresence[:name]
        end
    end
end