module BrooqlyDbEngine
    class Offer 
        include Dynamoid::Document

        table name: :offers, key: :id, capacity_mode: :on_demand
    
        field :name, :string
        field :country_code, :string
        field :starting_date, :integer
        field :message, :string
        field :status, :string
        field :code, :string
    end
end

    