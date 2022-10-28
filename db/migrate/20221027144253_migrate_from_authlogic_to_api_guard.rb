class MigrateFromAuthlogicToApiGuard < ActiveRecord::Migration[7.0]
  def change
    remove_columns :users, :login_count, :failed_login_count, type: :integer
    remove_columns :users, :last_request_at, :current_login_at, :last_login_at, type: :datetime
    remove_columns :users, :current_login_ip, :last_login_ip, type: :string
    remove_columns :users, :password_salt, :persistence_token, type: :string
    remove_columns :users, :active, :approved, :confirmed, type: :boolean

    rename_column :users, :crypted_password, :password_digest
  end
end
