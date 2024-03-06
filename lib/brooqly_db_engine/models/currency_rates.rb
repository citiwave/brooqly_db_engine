module BrooqlyDbEngine
    class CurrencyRate
        include Dynamoid::Document

        table name: :currency_rates, key: :id, capacity_mode: :on_demand

        field :rate_id, :string
        field :rate, :serialized
        field :date, :string

        global_secondary_index hash_key: :date, projected_attributes: :all
    end
end 