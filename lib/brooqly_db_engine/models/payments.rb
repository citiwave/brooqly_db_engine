module BrooqlyDbEngine
    class Payment  
        include Dynamoid::Document

        table name: :payments, key: :id, capacity_mode: :on_demand

        belongs_to :store
        has_many :treats

        field :store_id, :string
        field :treats_id, :array, of: :string
        field :amount, :string
        field :status, :string
    end
end