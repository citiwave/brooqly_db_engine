module BrooqlyDbEngine
    class Item  
        include Dynamoid::Document

        table name: :items, key: :id, capacity_mode: :on_demand
        
        def self.next_id
            s = Item.count
            s.to_i+1
        end 
    end
end