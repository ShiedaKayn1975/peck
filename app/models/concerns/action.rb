class Action
  attr_accessor :code, :label

  attr_accessor :hdl_show
  attr_accessor :hdl_authorized
  attr_accessor :hdl_commitable
  attr_accessor :hdl_commit

  # def initialize
  #   @attribute = attribute
  # end

  def commit! object, context
    execute object, context
  end

  def commitable? object, context
    !hdl_commitable || instance_exec(object, context, &hdl_commitable)
  end

  def show? object, context
    !hdl_show || instance_exec(object, context, &hdl_show)
  end

  def authorized? object, context
    !hdl_authorized || instance_exec(object, context, &hdl_authorized)  
  end

  private

  def commit object, context
    instance_exec(object, context, &hdl_commit)
  end

  def execute object, context
    verify_context context

    if commitable
      commit object, context
    end
  end

  def verify_context context
    unless context.actor
      raise Actionable::ActorMissingError.new("Actor is required to commit action")
    end
  end
end