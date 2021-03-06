class Api::V1::ProductResource < Api::V1::BaseResource
  attributes :name, :tags, :images, :creator_id, :quality_commitment, :price, :description, :categories, :created_at
  has_many :orders
  before_save :add_creator

  private
  def add_creator
    if @model.new_record?
      unless @model.creator_id
        @model.creator_id = context[:user].id
      end
    end
  end
end
