class UseBigintOnBestEffortsId < ActiveRecord::Migration[5.1]
  def change
    change_column :best_efforts, :id, 'bigint'
  end
end
