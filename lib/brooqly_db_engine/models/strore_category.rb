module BrooqlyDbEngine
    class StoreCategory  
        include Dynamoid::Document

        table name: :store_categories, key: :id, capacity_mode: :on_demand

        field :store_category_id, :string
        field :description, :string
        field :image_url, :string
        field :name, :string

        def self.next_id
            s = StoreCategory.count
            s.to_i+1
        end 
    end
end