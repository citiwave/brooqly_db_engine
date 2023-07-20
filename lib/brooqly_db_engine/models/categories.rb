module BrooqlyDbEngine
    class Category  
        include Dynamoid::Document

        table name: :categories, key: :id, capacity_mode: :on_demand
        
        field :category_id, :string
        field :description, :string
        field :icon, :string
        field :image_url, :string
        field :name, :string
        
        def self.next_id
            s = Category.count
            s.to_i+1
        end 
    end
end