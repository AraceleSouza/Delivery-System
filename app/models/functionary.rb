class Functionary < ApplicationRecord
  before_validation :add_functionary_to_shipping_company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :shipping_company, optional: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
         
  private

  def add_functionary_to_shipping_company
    functionary_domain_email = self.email.split("@")[1]
    shipping_company = ShippingCompany.find_by(email_domain: functionary_domain_email)
    if shipping_company.present?
      self.shipping_company = shipping_company
    else
      errors.add(:email, "não cadastrado no sistema.")
    end
  end
end

