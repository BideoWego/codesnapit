class SnapItTheme < ActiveRecord::Base
  has_many :snap_its
  has_many :snap_it_proxies
end
