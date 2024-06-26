# frozen_string_literal: true

require_relative "brooqly_db_engine/version"
require 'dynamoid'

module BrooqlyDbEngine
  @@endpoint = ""
  @@aws_access_key = ""
  @@aws_secret_key = ""
  @@aws_region = ""
  autoload :Store,				  "brooqly_db_engine/models/stores"
  autoload :StoreCategory,  "brooqly_db_engine/models/store_categories"
  autoload :Treat,				  "brooqly_db_engine/models/treats"
  autoload :TreatIntent,				  "brooqly_db_engine/models/treat_intents"
  autoload :User,				    "brooqly_db_engine/models/users"
  autoload :Item,				    "brooqly_db_engine/models/items"
  autoload :Payment,				"brooqly_db_engine/models/payments"
  autoload :Category,			  "brooqly_db_engine/models/categories"
  autoload :Friendship,			  "brooqly_db_engine/models/friendships"
  autoload :Location,				  "brooqly_db_engine/models/locations"
  autoload :Notification,				  "brooqly_db_engine/models/notifications"
  autoload :Order,				  "brooqly_db_engine/models/orders"
  autoload :CheckIn,				  "brooqly_db_engine/models/checkins"
  autoload :Region,				  "brooqly_db_engine/models/regions"
  autoload :Post,				  "brooqly_db_engine/models/posts"
  autoload :ProfilePicture,				  "brooqly_db_engine/models/profile_pictures"
  autoload :Story,				  "brooqly_db_engine/models/stories"
  autoload :ChatUser,				  "brooqly_db_engine/models/chat_users"
  autoload :Device,				  "brooqly_db_engine/models/devices"
  autoload :CurrencyRate,				  "brooqly_db_engine/models/currency_rates"
  autoload :ModeratedImage,				  "brooqly_db_engine/models/moderated_images"
  autoload :StoreList,               "brooqly_db_engine/models/store_lists"
  autoload :PromotionalTreat,    "brooqly_db_engine/models/promotional_treats"
  autoload :Offer,    "brooqly_db_engine/models/offers"
  def self.configure(params = {})
    Dynamoid.configure do |config|
      # Local DDB endpoint:
      config.endpoint = params["endpoint"]
      config.access_key = params["aws_access_key"]
      config.secret_key = params["aws_secret_key"]
      config.region = params["aws_region"]
      # Do not add prefixes to table names. By default dynamoid uses `dynamoid_#{application_name}_#{environment}` prefix:
      config.namespace = "brooqly"
      puts params
    end
  end
  class Error < StandardError; end
  # Your code goes here...
end
