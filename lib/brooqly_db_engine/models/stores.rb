module BrooqlyDbEngine
    class Store  
        include Dynamoid::Document

        table name: :stores, key: :id, capacity_mode: :on_demand
        
        field name :address :set, of: { serialized: { serializer: JSON } }
        field name :contact :set, of: { serialized: { serializer: JSON } }
        field name :data :set, of: { serialized: { serializer: JSON } }
        field name :financial :set, of: { serialized: { serializer: JSON } }
        field name :items :set, of: { serialized: { serializer: JSON } }
        field name :presence :set, of: { serialized: { serializer: JSON } }    
        field name :owners :array, of: :integer
    end
end