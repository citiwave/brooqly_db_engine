module BrooqlyDbEngine
    class Payment  
        include Dynamoid::Document

        table name: :payments, key: :id, capacity_mode: :on_demand

        belongs_to :store
        has_many :treats

        field :store_ids, :string
        field :treat_ids, :array, of: :string
        field :amount, :string
        field :status, :string
    end
end