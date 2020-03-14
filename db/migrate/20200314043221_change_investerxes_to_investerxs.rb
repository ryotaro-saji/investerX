class ChangeInvesterxesToInvesterxs < ActiveRecord::Migration[5.2]
  def change
    rename_table :investerxes, :investerxs
  end
end
