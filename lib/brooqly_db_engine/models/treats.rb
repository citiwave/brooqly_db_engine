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
        field :is_remote, :string
        field :is_inshop, :string
        
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
            current_time_unix_timestamp = (current_time.to_i * 1000)
            future_time = Time.now.utc + (days * 24 * 60 * 60) - 3.months
            future_time_unix_timestamp = (future_time.to_i * 1000)
            # Where conditions may contain only one condition for THE SAME attribute. Following conditions are ignored: {:"date.gt"=>1682765631788}
            # Treat.where('date.gt':current_time_unix_timestamp, 'date.lt':future_time_unix_timestamp).to_a
            Treat.where('date.between': [current_time_unix_timestamp, future_time_unix_timestamp]).to_a
        end
        def self.counter(since)
            # unix utc timestamp now
            current_time = Time.now.utc
            case since
            when "today"
                from = (current_time.beginning_of_day.to_i * 1000)
                previous_day_start = (current_time.yesterday.beginning_of_day.to_i * 1000)
                previous_day_end = (current_time.yesterday.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_day_start, previous_day_end]).count
            when "this_week"
                from = (current_time.beginning_of_week.to_i * 1000).to_i
                previous_week_start = (current_time.prev_week.beginning_of_week.to_i * 1000)
                previous_week_end = ((current_time - 7.days).to_i * 1000)
                past_treats = Treat.where('date.between': [previous_week_start, previous_week_end]).count
            when "this_month"
                from = (current_time.beginning_of_month.to_i * 1000)
                previous_month_start = (current_time.prev_month.beginning_of_month.to_i * 1000)
                previous_month_end = (current_time.prev_month.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_month_start, previous_month_end]).count
            when "this_year"
                from = (current_time.beginning_of_year.to_i * 1000)
                previous_year_start = (current_time.prev_year.beginning_of_year.to_i * 1000)
                previous_year_end = (current_time.prev_year.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_year_start, previous_year_end]).count
            else
              return ""
            end
            # Current treats
            treats = Treat.where('date.gt':from).count
             # Calculate the percentage growth
            if past_treats != 0
                percentage_growth = ((treats.to_f - past_treats) / past_treats) * 100
                rounded_percentage_growth = percentage_growth.round(2)
            else
                rounded_percentage_growth = 0
            end
            return treats , rounded_percentage_growth
        end
        def self.income(since)
            # unix utc timestamp now
            current_time = Time.now.utc
            case since
            when "today"
                from = (current_time.beginning_of_day.to_i * 1000)
                previous_day_start = (current_time.yesterday.beginning_of_day.to_i * 1000)
                previous_day_end = (current_time.yesterday.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_day_start, previous_day_end]).to_a
            when "this_week"
                from = (current_time.beginning_of_week.to_i * 1000).to_i
                previous_week_start = (current_time.prev_week.beginning_of_week.to_i * 1000)
                previous_week_end = ((current_time - 7.days).to_i * 1000)
                past_treats = Treat.where('date.between': [previous_week_start, previous_week_end]).to_a
            when "this_month"
                from = (current_time.beginning_of_month.to_i * 1000)
                previous_month_start = (current_time.prev_month.beginning_of_month.to_i * 1000)
                previous_month_end = (current_time.prev_month.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_month_start, previous_month_end]).to_a
            when "this_year"
                from = (current_time.beginning_of_year.to_i * 1000)
                previous_year_start = (current_time.prev_year.beginning_of_year.to_i * 1000)
                previous_year_end = (current_time.prev_year.to_i * 1000)
                past_treats = Treat.where('date.between': [previous_year_start, previous_year_end]).to_a
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
                percentage_growth = ((current_earnings.to_f - past_earnings) / past_earnings) * 100
                rounded_percentage_growth = percentage_growth.round(2)
            else
                rounded_percentage_growth = 0
            end
            return current_earnings , rounded_percentage_growth
        end
        def self.total_earnings()
            total_earnings = Treat.all.sum(&:total_price)
        end
        def self.dashboard_chart(period,input_array)
            # input_array -> xaxis -> time
            # output_array -> yaxis -> income
            time_end = Time.now.utc
            output_array = []
            case period
            when "1d"
                # fill this code last
            when "1w"
                time_start = (time_end - 7.days).beginning_of_day
                treats = Treat.where('date.between': [time_start.to_i * 1000, time_end.to_i * 1000])
                hash = treats.group_by {|e| Time.at(e[:date].to_i/1000).strftime('%b %d') }
            when "1m"
                time_start = (time_end - 1.month).beginning_of_day
                treats = Treat.where('date.between': [time_start.to_i * 1000, time_end.to_i * 1000])
                hash = treats.group_by {|e| Time.at(e[:date].to_i/1000).strftime('%b %d') }
            when "6m"
                time_start = (time_end - 6.months).beginning_of_month
                treats = Treat.where('date.between': [time_start.to_i * 1000, time_end.to_i * 1000])
                hash = treats.group_by {|e| Time.at(e[:date].to_i/1000).strftime('%b %Y') }
            when "1y"
                time_start = (time_end - 1.year).beginning_of_month
                treats = Treat.where('date.between': [time_start.to_i * 1000, time_end.to_i * 1000])
                hash = treats.group_by {|e| Time.at(e[:date].to_i/1000).strftime('%b %Y') }
            else
              return ""
            end
            # Calculate total period earnings 
            period_earnings =  treats.inject(0) { |sum, x| sum + x["total_price"] }
            # Now we must distribute the earnings per time period
            input_array.each do |time_period|
                # Check if that time_period had earnings
                if hash[time_period]
                    income = hash[time_period].inject(0) { |sum, x| sum + x["total_price"] }
                    output_array << income
                else
                    output_array << 0
                end
            end
            return output_array , period_earnings
        end
    end
end
