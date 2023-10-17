module BrooqlyDbEngine
    class CurrencyRate
        include Dynamoid::Document

        table name: :currency_rates, key: :id, capacity_mode: :on_demand

        field :rate_id, :string
        field :rate, :serialized
        field :date, :string
    end
end 