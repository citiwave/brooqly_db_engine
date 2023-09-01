module BrooqlyDbEngine
    class Order
        include Dynamoid::Document

        table name: :orders, key: :id, capacity_mode: :on_demand

        field :address, :serialized
        field :treat_id, :string
        field :store_id, :string
        field :item, :serialized
        field :status, :string
        field :delivery_date, :string
    end
end
