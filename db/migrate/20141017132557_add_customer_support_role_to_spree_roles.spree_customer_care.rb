# This migration comes from spree_customer_care (originally 20140207112938)
class AddCustomerSupportRoleToSpreeRoles < ActiveRecord::Migration
  def change
    Spree::Role.create(name: 'customer_assistant')
  end
end
