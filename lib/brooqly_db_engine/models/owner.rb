module BrooqlyDbEngine
    class Owner  
        include Dynamoid::Document

        table name: :owners, key: :id, capacity_mode: :on_demand

        field :user_id, :string
        field :permissions,  :serialized
        field :account,  :serialized

        def self.next_id
            s = Owner.count
            s.to_i+1
        end 
    end
end