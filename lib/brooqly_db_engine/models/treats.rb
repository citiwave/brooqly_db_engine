module BrooqlyDbEngine
    class Treat  
        include Dynamoid::Document

        table name: :treats, key: :id, capacity_mode: :on_demand
        
        field :code, :string
        field :currency_code, :string
        field :date, :integer
        field :from, :integer
        field :item, :integer
        field :message, :string
        field :pay_date, :integer
        field :pay_status, :string
        field :price, :float
        field :purchase_date, :integer
        field :quantity, :integer
        field :ref, :string
        field :status, :string
        field :store, :integer
        field :to, :integer
        field :total_price, :float
        field :type, :string
    end
end