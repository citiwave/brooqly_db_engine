module BrooqlyDbEngine
    class PromotionalTreat 
        include Dynamoid::Document

        table name: :promotional_treats, key: :id, capacity_mode: :on_demand
    
        field :currency_code, :string
        field :offer_id, :string
        field :country_code, :string
        field :data, :serialized
        field :discount, :string
        field :store_name, :string
        field :store_id, :string
        field :total_price, :string
        field :total_quantity, :integer
        field :remaining_quantity, :integer
        field :current_round, :string
    end
end

    