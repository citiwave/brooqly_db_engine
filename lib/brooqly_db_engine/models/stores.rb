module BrooqlyDbEngine
    class Store  
        include Dynamoid::Document

        table name: :stores, key: :id, capacity_mode: :on_demand
        
        field :address, :serialized 
        field :contact, :serialized
        field :images, :serialized
        field :data,  :serialized
        field :financial,  :serialized
        field :items, :serialized
        field :bpresence,  :serialized
        field :store_id,  :string
        field :owners, :array, of: :integer
        field :status,  :string
        field :is_eshop,  :string
	    field :location_id, :string
        field :has_payment_provider, :string
        field :country_code, :string
        field :email, :string
        field :mode, :string

        global_secondary_index hash_key: :country_code
        global_secondary_index hash_key: :store_id
        global_secondary_index hash_key: :status, projected_attributes: :all 
        
        def name=(name)
            self.bpresence = {name: name}
        end
        def name
            self.bpresence[:name]
        end
        def self.pending_shops_counter
            stores = Store.where(:status => "pending").count
        end
        def self.pending_shops
            stores = Store.where(:status => "pending").to_a
        end
        def self.counter(since)
            # unix utc timestamp now
            current_time = Time.now.utc
            case since
            when "today"
                from = (current_time.beginning_of_day).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_day_start = (current_time.yesterday.beginning_of_day).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_day_end = (current_time.yesterday).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_stores = Store.where('created_at.between': [previous_day_start, previous_day_end]).count
            when "this_week"
                from = (current_time.beginning_of_week).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_week_start = (current_time.prev_week.beginning_of_week).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_week_end = (current_time - 7.days).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_stores = Store.where('created_at.between': [previous_week_start, previous_week_end]).count
            when "this_month"
                from = (current_time.beginning_of_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_month_start = (current_time.prev_month.beginning_of_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_month_end = (current_time.prev_month).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_stores = Store.where('created_at.between': [previous_month_start, previous_month_end]).count
            when "this_year"
                from = (current_time.beginning_of_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_year_start = (current_time.prev_year.beginning_of_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                previous_year_end = (current_time.prev_year).strftime('%a, %d %b %Y %H:%M:%S %z')
                past_stores = Store.where('created_at.between': [previous_year_start, previous_year_end]).count
            else
              return ""
            end
            # Current stores
            stores = Store.where('created_at.gt':from).count
             # Calculate the percentage growth
            if past_stores != 0
                percentage_growth = ((stores.to_f - past_stores) / past_stores) * 100
                rounded_percentage_growth = percentage_growth.round(2)
            else
                rounded_percentage_growth = 0
            end
            return stores , rounded_percentage_growth
        end
    end
end
