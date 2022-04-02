module Actionable
  def self.included model
    class << base
      def action name, options = {}, &block

      end
    end
  end
end