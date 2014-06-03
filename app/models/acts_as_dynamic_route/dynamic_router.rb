class ActsAsDynamicRoute::DynamicRouter < ActiveRecord::Base
  attr_accessible :klass, :field, :request_method, :path, :options
  store :options

  validates_uniqueness_of :path, scope: [:klass, :field, :request_method ]

  def self.load
    Rails.application.routes.draw do

      ActsAsDynamicRoute::DynamicRouter.all.each do |dyn_router|

        klass, field, request_method  = dyn_router.klass.safe_constantize, dyn_router.field, dyn_router.request_method.to_sym
        path, options                 = dyn_router.path.clone, dyn_router.options.clone.deep_symbolize_keys

        raise "Exception for ActsAsDynamicRoute::DynamicRouter : path does not contains field token for #{dyn_router.to_json}" unless path.include?(":#{field}")

        scope = options.delete(:scope)
        scope ||= :all if scope.blank? || !klass.respond_to?(scope)

        klass.send(scope).each do |item|
          field_value   = item.send(field)
          item_path     = path.gsub(/:#{field}/, field_value.to_s )
          item_options  = options.clone
          item_options.deep_merge!({ defaults: { id: item.id } })

          send(:map_method, request_method, item_path, item_options)
        end
      end
    end
  end

  def self.reload
    Rails.application.routes_reloader.reload!
  end

  private

  def self.register(klass, field, *args)
    hash_options = args.extract_options!.deep_symbolize_keys.reject{ |_,v| v.nil? }

    options = {
      request_method: :get, path: ":#{field}"
      }.deep_merge!(hash_options)

    request_method, path = options.delete(:request_method), options.delete(:path)

    dyn_router = new(klass: klass.to_s, field: field, request_method: request_method, path: path, options: options)

    dyn_router.save if dyn_router.valid? # Do not save an already existing route.
  end
end

# http://stackoverflow.com/questions/9365813/repository-or-gateway-pattern-in-ruby
# http://hawkins.io/2013/10/implementing_the_repository_pattern/
