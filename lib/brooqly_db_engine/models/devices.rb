module BrooqlyDbEngine
    class Device
        include Dynamoid::Document

        table name: :devices_ids, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :device_id, :string
        global_secondary_index hash_key: :device_id
        global_secondary_index hash_key: :user_id
    end
end