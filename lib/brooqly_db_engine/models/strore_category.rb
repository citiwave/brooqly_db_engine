module BrooqlyDbEngine
    class StoreCategory  
        include Dynamoid::Document

        table name: :store_categories, key: :id, capacity_mode: :on_demand
        
        def self.next_id
            s = StoreCategory.count
            s.to_i+1
        end 
    end
end