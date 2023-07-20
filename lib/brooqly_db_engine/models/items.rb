module BrooqlyDbEngine
    class Item  
        include Dynamoid::Document

        table name: :items, key: :id, capacity_mode: :on_demand
        
        field :category, :string
        field :description, :string
        field :item_id, :string
        field :image_url, :string
        field :name, :string
        field :names, :serialized

        def self.next_id
            s = Item.count
            s.to_i+1
        end 
    end
end