# frozen_string_literal: true

# Monkey patching for Mongoid::Document
# See https://www.mongodb.com/docs/mongoid/current/ for Gem use.
module Mongoid
  module Document
    def as_json(options = {})
      attrs = super(options)

      # Convert BSON::ObjectId to String
      # from displayed attributes on mongoid documents when represented as JSON
      id = { _id: attrs['_id'].to_s }
      attrs.merge(id)

      # Convert snake_case to camelCase except _id on Response JSON
      attrs.deep_transform_keys! { |key| key == '_id' ? key : key.camelize(:lower) }
    end
  end
end

# Monkey patching for BSON
module BSON
  class ObjectId
    alias to_json to_s
    alias as_json to_s
  end
end
