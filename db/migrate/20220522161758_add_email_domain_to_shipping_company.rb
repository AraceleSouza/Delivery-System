class AddEmailDomainToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :email_domain, :string
  end
end
