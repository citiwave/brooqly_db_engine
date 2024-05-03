module BrooqlyDbEngine
    class PromotionalTreat 
        include Dynamoid::Document

        table name: :promotional_treats, key: :id, capacity_mode: :on_demand
    
        field :currency_code, :string
        field :name, :string
        field :country_code, :string
        field :starting_date, :integer
        field :message, :string
        field :status, :string
        field :data, :serialized
        field :discount, :string
        field :store_name, :string
        field :store_id, :string
        field :total_price, :string
        field :total_quantity, :integer
        field :remaining_treats, :integer
        field :current_round, :string
        field :code, :string
    end
end

    