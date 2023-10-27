module BrooqlyDbEngine
    class Category  
        include Dynamoid::Document

        table name: :categories, key: :id, capacity_mode: :on_demand
        
        field :category_id, :string
        field :description, :string
        field :icon, :string
        field :image_url, :string
        field :name, :string
        field :store_categories :array, of: :string

        global_secondary_index hash_key: :category_id
        

    end
end