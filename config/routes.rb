Rails.application.routes.draw do
  ActsAsDynamicRoute::DynamicRouter.load if ActsAsDynamicRoute::DynamicRouter.table_exists?
end
