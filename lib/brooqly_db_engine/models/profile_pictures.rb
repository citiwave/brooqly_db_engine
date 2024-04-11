module BrooqlyDbEngine
    class ProfilePicture
        include Dynamoid::Document

        table name: :profile_pictures, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :image_url, :string
        field :caption, :string
        field :cheers, :serialized
        field :views, :serialized
        field :comments, :serialized
        field :date, :string
        field :reports, :serialized
        field :status
        field :archived, :string
        global_secondary_index hash_key: :user_id 
    end
end     