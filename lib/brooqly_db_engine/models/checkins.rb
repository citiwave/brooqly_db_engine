module BrooqlyDbEngine
    class Checkin
        include Dynamoid::Document

        table name: :checkins, key: :id, capacity_mode: :on_demand

        field :store_id, :string
        field :user_id, :string
        field :date, :string
        global_secondary_index hash_key: :store_id
        global_secondary_index hash_key: :user_id
    end
end
