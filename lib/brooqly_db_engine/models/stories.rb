module BrooqlyDbEngine
    class Story
        include Dynamoid::Document

        table name: :stories, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :preview, :string
        field :pages, :serialized
        field :date, :string
        global_secondary_index hash_key: :user_id
    end
end    
