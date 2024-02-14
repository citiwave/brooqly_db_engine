module BrooqlyDbEngine
    class ChatUser
        include Dynamoid::Document

        table name: :chat_users, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :chat_user_id, :string
        field :username, :string
        field :password, :string
        field :state, :serialized
        global_secondary_index hash_key: :chat_user_id
        global_secondary_index hash_key: :user_id
    end
end     