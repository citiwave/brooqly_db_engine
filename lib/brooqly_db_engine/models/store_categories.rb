module BrooqlyDbEngine
    class StoreCategory  
        include Dynamoid::Document

        table name: :store_categories, key: :id, capacity_mode: :on_demand

        field :store_category_id, :string
        field :description, :string
        field :image_url, :string
        field :name, :string

        global_secondary_index hash_key: :store_category_id

    end
end
