class Rating < ApplicationRecord
  enum status: [ :低, :中, :高 ]
end
