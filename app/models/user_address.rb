class UserAddress < ApplicationRecord
  belongs_to :user
  extend Enumerize

  enumerize :country_code, in: ISO3166::Country.translations.invert
end
