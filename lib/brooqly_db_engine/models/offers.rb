module BrooqlyDbEngine
    class Offer 
        include Dynamoid::Document

        table name: :offers, key: :id, capacity_mode: :on_demand
    
        field :name, :string
        field :country_code, :string
        field :message, :string
        field :status, :string
        field :start_date, :string
        field :end_date, :string
        field :code, :string
        field :sender_id, :string

        def remaining_quantity
            promotional_treats =  PromotionalTreat.where(:offer_id => self.id).to_a
            if promotional_treats.empty?
                return "0/0"
            else
                quantity = promotional_treats.sum {|e| e.total_quantity}
                remaining_quantity = promotional_treats.sum {|e| e.remaining_quantity}
                return "#{remaining_quantity}/#{quantity}"
            end
        end
    end
end

    