module BrooqlyDbEngine
    class Category  
        include Dynamoid::Document

        table name: :categories, key: :id, capacity_mode: :on_demand
        
        def self.next_id
            s = Category.count
            s.to_i+1
        end 
    end
end