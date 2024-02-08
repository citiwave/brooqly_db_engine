module BrooqlyDbEngine
    class User  
        include Dynamoid::Document

        table name: :users, key: :id, capacity_mode: :on_demand
        
        field :personal_details,  :serialized
        field :user_data, :serialized
        field :user_id,  :string
        field :notifications, :serialized
        field :friends, :array, of: :string
        field :location, :serialized
        field :blocked, :array, of: :string
        field :is_public, :string
        field :last_activity, :string

        global_secondary_index hash_key: :user_id
        def self.counter(since)
            # unix utc timestamp now
            current_time = Time.now.utc
            case since
            when "today"
                from = (current_time.beginning_of_day).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_day_start = (current_time.yesterday.beginning_of_day).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_day_end = (current_time.yesterday).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_users = User.where('created_at.between': [previous_day_start, previous_day_end]).count
            when "this_week"
                from = (current_time.beginning_of_week).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_week_start = (current_time.prev_week.beginning_of_week).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_week_end = (current_time - 7.days).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_users = User.where('created_at.between': [previous_week_start, previous_week_end]).count
            when "this_month"
                from = (current_time.beginning_of_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_month_start = (current_time.prev_month.beginning_of_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_month_end = (current_time.prev_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_users = User.where('created_at.between': [previous_month_start, previous_month_end]).count
            when "this_year"
                from = (current_time.beginning_of_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_year_start = (current_time.prev_year.beginning_of_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_year_end = (current_time.prev_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_users = User.where('created_at.between': [previous_year_start, previous_year_end]).count
            else
              return ""
            end
            # Current users
            users = User.where('created_at.gt':from).count
             # Calculate the percentage growth
            if past_users != 0
                percentage_growth = ((users.to_f - past_users) / past_users) * 100
                rounded_percentage_growth = percentage_growth.round(2)
            else
                rounded_percentage_growth = 0
            end
            return users , rounded_percentage_growth
        end
    end
end