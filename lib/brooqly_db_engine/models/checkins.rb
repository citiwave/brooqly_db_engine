module BrooqlyDbEngine
    class CheckIn
        include Dynamoid::Document

        table name: :checkins, key: :id, capacity_mode: :on_demand

        field :store_id, :string
        field :user_id, :string
        field :post_id, :string
        field :status, :string
        field :date, :string
        field :archived, :string
        field :metadata, :serialized
        global_secondary_index hash_key: :store_id
        global_secondary_index hash_key: :user_id
        global_secondary_index hash_key: :post_id
    end
end
