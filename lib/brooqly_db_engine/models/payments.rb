module BrooqlyDbEngine
    class Payment  
        include Dynamoid::Document

        table name: :payments, key: :id, capacity_mode: :on_demand

        field :store_id, :string
        field :payment_id, :string
        field :transaction_id, :string
        field :treats_id, :array, of: :string
        field :amount, :string
        field :currency_code, :string
        field :status, :string
        field :date, :string
        field :invoice_no, :string
        field :invoice_url, :string
        global_secondary_index hash_key: :store_id
        def self.have_status(status)
            # Return how many treats are purchased (so not consumed and paid)
            Payment.where(:status => status).to_a
        end
    end
end




