module BrooqlyDbEngine
    class Notification  
        include Dynamoid::Document

        table name: :notifications, key: :id, capacity_mode: :on_demand
        
        field :subject, :string 
        field :body, :string 
        field :sender, :string
        field :user_id, :string
        field :notification_type, :string 
        field :users, :array, of: :string
        field :group, :array, of: :string
        field :date, :string 
        field :image_url, :string
        field :secondary_image_url, :string
        field :element_id, :string

        # global_secondary_index hash_key: :location_id
        def category
        end
    end
end