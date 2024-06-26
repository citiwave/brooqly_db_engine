module BrooqlyDbEngine
    class Post
        include Dynamoid::Document

        table name: :posts, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :store_id, :string
        field :image_url, :string
        field :caption, :string
        field :cheers, :serialized
        field :views, :serialized
        field :comments, :serialized
        field :date, :string
        field :ptimestamp, :string
        field :reports, :serialized
        field :metadata, :serialized
        field :status
        field :archived, :string
        field :is_public, :string
        global_secondary_index hash_key: :store_id
        global_secondary_index hash_key: :user_id 
        global_secondary_index hash_key: :id, range_key: :date, name: "brooqly_posts_index_sorted_id", projected_attributes: :all
    end
end     