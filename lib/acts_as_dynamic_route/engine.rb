require "acts_as_dynamic_route/hook"

module ActsAsDynamicRoute
  class Engine < ::Rails::Engine

    # On the load of the application destroy all existing DynamicRouter that exist
    # The active record only exist to synchronize all the server instance
    initializer 'acts_as_dynamic_route.clean_dynamic_route' do |app|
      DynamicRouter.destroy_all  if DynamicRouter.table_exists?
    end

    # Run it only once time for production but relaod it in development
    config.to_prepare do
      ActiveRecord::Base.send(:include, ActsAsDynamicRoute::Hook)
    end
  end
end
