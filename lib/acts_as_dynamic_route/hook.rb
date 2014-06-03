module ActsAsDynamicRoute
  module Hook
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_dynamic_route(field, *args)
        DynamicRouter.send(:register, self, field, *args)

        class_eval %Q?
          after_save :reload_routes
          def reload_routes
            DynamicRouter.reload
          end
          private :reload_routes
        ?
      end
    end
  end
end
