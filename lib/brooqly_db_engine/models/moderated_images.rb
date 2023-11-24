module BrooqlyDbEngine
    class ModeratedImage
        include Dynamoid::Document

        table name: :moderated_images, key: :id, capacity_mode: :on_demand
        field :user_id, :string
        field :image_type, :string
        field :image_url, :string
        field :moderation_content, :serialized
        field :status, :string
        
        global_secondary_index hash_key: :image_url
    end
end  