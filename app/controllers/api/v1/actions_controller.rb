class Api::V1::ActionsController < Api::V1::ApiController
  before_action :get_object

  def create
    
  end

  private 

  OBJECT_NAME_REGEX = Regexp.new(
    '/([^/]+)/[^/]+/actions'
  )

  def get_object
    @object_name = request.url.match(OBJECT_NAME_REGEX)[1]
    @object_class = @object_name.classify.constantize
    object_id_key = "#{@object_name.singularize}_id"
    object_id     = params[object_id_key]

    @object = @object_class.find(object_id)
  end
end
