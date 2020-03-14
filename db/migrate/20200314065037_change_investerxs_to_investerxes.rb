class ChangeInvesterxsToInvesterxes < ActiveRecord::Migration[5.2]
  def change
    rename_table :investerxs, :investerxes
  end
end
