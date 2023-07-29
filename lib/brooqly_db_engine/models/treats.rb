module BrooqlyDbEngine
    class Treat  
        include Dynamoid::Document

        table name: :treats, key: :id, capacity_mode: :on_demand
        
        field :treat_id,  :string
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
        
        global_secondary_index hash_key: :store
        global_secondary_index hash_key: :item
        global_secondary_index hash_key: :from
        global_secondary_index hash_key: :to

        def self.purchased_treats
            # Return how many treats are purchased (so not consumed and paid)
            Treat.where(:status => "purchased").to_a
        end
        def self.consumed_treats
            # Return how many treats are consumed 
            Treat.where(:status => "consumed").where('pay_status.null': true).to_a
        end
        def self.paid_treats
            # Return how many treats are unpaid (consumed and not paid)
            Treat.where(:pay_status => "paid").to_a
        end
        def self.expire_soon(days)
            # Tokens will expire 3 months after they were created
            current_time = Time.now.utc - 3.months
            current_time_unix_timestamp = (current_time.to_f * 1000).to_i
            future_time = current_time + (days * 24 * 60 * 60)
            future_time_unix_timestamp = (future_time.to_f * 1000).to_i
            # Where conditions may contain only one condition for THE SAME attribute. Following conditions are ignored: {:"date.gt"=>1682765631788}
            # Treat.where('date.gt':current_time_unix_timestamp, 'date.lt':future_time_unix_timestamp).to_a
            Treat.where('date.between': [current_time_unix_timestamp, future_time_unix_timestamp]).to_a
        end
        def self.income(since)
            # unix utc timestamp now
            current_time = Time.now.utc
            case since
            when "today"
                from = (current_time.beginning_of_day.to_f * 1000).to_i
                previous_day_start = (current_time.yesterday.beginning_of_day.to_f * 1000).to_i
                previous_day_end = (current_time.yesterday.to_f * 1000).to_i
                past_treats = Treat.where('date.between': [previous_day_start, previous_day_end]).to_a
            when "this_week"
                from = (current_time.beginning_of_week.to_f * 1000).to_i
                previous_week_start = (current_time.prev_week.beginning_of_week.to_f * 1000).to_i
                previous_week_end = ((current_time - 7.days).to_f * 1000).to_i
                past_treats = Treat.where('date.between': [previous_week_start, previous_week_end]).to_a
            when "this_month"
                from = (current_time.beginning_of_month.to_f * 1000).to_i
                previous_month_start = (current_time.prev_month.beginning_of_month.to_f * 1000).to_i
                previous_month_end = (current_time.prev_month.to_f * 1000).to_i
                past_treats = Treat.where('date.between': [previous_month_start, previous_month_end]).to_a
            else
              return ""
            end
            # Current treats
            treats = Treat.where('date.gt':from).to_a
            current_earnings =  treats.inject(0) { |sum, x| sum + x["total_price"] }
            # Past treats 
            past_earnings =  past_treats.inject(0) { |sum, x| sum + x["total_price"] }
            # Calculate the percentage growth
             # Calculate the percentage growth
            if past_earnings != 0
                percentage_growth = ((current_earnings - past_earnings) / past_earnings) * 100
            else
                percentage_growth = 0
            end
            return current_earnings , percentage_growth
        end
        
    end
end