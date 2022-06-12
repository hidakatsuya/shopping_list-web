class Token < ApplicationRecord
  belongs_to :user

  class << self
    def generate_token
      Base64.strict_encode64(SecureRandom.uuid)
    end
  end

  def regenerate_value!
    self.value = self.class.generate_token
  end
end
