class IncreaseFieldLengthOfUserImageUrl < ActiveRecord::Migration
  def change
    change_column :users, :image, :text
  end
end
