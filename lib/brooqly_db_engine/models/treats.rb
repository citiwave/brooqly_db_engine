module BrooqlyDbEngine
    class Treat  
        include Dynamoid::Document

        table name: :treats, key: :id, capacity_mode: :on_demand
        
        field :code, :string
        field :currency_code, :string
        field :to, :string
        field :date, :integer
        field :from, :string
        field :item, :string
        field :message, :string
        field :pay_date, :integer
        field :pay_status, :string
        field :price, :integer
        field :purchase_date, :integer
        field :redeem_date, :integer
        field :quantity, :integer
        field :ref, :string
        field :status, :string
        field :store, :string
        field :total_price, :integer
        field :type, :string
        field :treat_id,  :string

        def self.next_id
            s = Treat.count
            s.to_i+1
        end        
    end
end