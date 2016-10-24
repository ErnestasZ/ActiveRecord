class Customer < ActiveRecord::Base
 validates :name, :surname, presence: true
end
