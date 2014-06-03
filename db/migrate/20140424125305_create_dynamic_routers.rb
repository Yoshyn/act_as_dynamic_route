class CreateDynamicRouters < ActiveRecord::Migration
  def up
    create_table :dynamic_routers do |t|
      t.string :klass,                    limit: 255
      t.string :field,                    limit: 255
      t.string :request_method,           limit: 255
      t.string :path,                     limit: 255
      t.text   :options
    end
  end

  def down
    drop_table :dynamic_routers
  end
end
