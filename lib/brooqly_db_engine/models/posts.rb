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
        global_secondary_index hash_key: :store_id
        global_secondary_index hash_key: :user_id
    end
end     