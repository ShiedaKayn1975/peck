module Actionable
  def self.included model
    # to use Model::Actions[action_name]
    # to use Model::Actions.all
    model.const_set :Actions, (Module.new do
      def self.all
        @actions
      end

      def self.[] code
        (@actions || {})[code]
      end

    end) unless model.const_defined?(:Actions)

    class << model
      def action name, options = {}, &block
        action_def = DefineAction.new name, options

        existing_action = (self::Actions || {})[name]

        if existing_action
          action_def.action = existing_action
          action_def.with_options = options
        end

        action_def.instance_eval &block if block_given?

        self::Actions.class_eval do
          @actions ||= {}
          @actions[name] = action_def.action
        end
      end
    end
  end

  class DefineAction
    attr_accessor :action

    def initialize name, options = {}
      @action = Action.new
      @action.code = name
    end

    def label label
      @action.label = label
    end

    def show? &block
      @action.hdl_show = block
    end

    def commitable? &block
      @action.hdl_commitable = block
    end

    def authorized? &block
      @action.hdl_authorized = block
    end

    def commit &block
      @action.hdl_commit = block
    end
  end

  class Error < StandardError
  end

  
end