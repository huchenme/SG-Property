# == Schema Information
#
# Table name: properties
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  bedroom    :integer
#  bathroom   :integer
#  price      :integer
#  size       :integer
#  sitename   :string(255)
#  link       :string(255)
#  phone      :string(255)
#  agent_name :string(255)
#  image_url  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Property < ActiveRecord::Base
  attr_accessible :agent_name, :bathroom, :bedroom, :image_url, :link, :name, :phone, :price, :sitename, :size
end
