class Site < ActiveRecord::Base
  has_many :scores

  def to_param
    shlaa_ref
  end
end
