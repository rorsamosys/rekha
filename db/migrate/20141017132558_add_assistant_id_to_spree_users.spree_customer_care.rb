# This migration comes from spree_customer_care (originally 20140207124217)
class AddAssistantIdToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :assistant_id, :integer
  end
end
