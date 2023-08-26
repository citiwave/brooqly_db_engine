module BrooqlyDbEngine
    class Friendship 
        include Dynamoid::Document

        table name: :friendships, key: :id, capacity_mode: :on_demand

        field :sender_id, :string
        field :receiver_id, :string
        field :status, :integer
        field :elevated_status, :integer
        field :date, :string

        global_secondary_index hash_key: :sender_id
        global_secondary_index hash_key: :receiver_id
	
    end
end

# ENUM Statuses [
# 0 Friend Request Sent
# 1 Friend Request Accepted
# -1 Friend Request Rejected
# -2 Friend Blocked
#
#
# ENUM Elevated Statuses [
# 0 Friend
# 1 Relationship
# 2 Married
