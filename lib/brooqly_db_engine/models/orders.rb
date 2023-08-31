module BrooqlyDbEngine
    class Order
        include Dynamoid::Document

        table name: :orders, key: :id, capacity_mode: :on_demand

        field :address, :serialize
        field :treat_id, :string
        field :item, :serialize
        field :status, :string
        field :delivery_date, :string
    end
end
