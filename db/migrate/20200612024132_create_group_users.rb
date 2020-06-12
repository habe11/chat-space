class CreateGroupUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_users do |t|
      t.references :group, foreign_key: true
      # foreign_key: true = 外部キーに対して対応するレコードが必ず存在するように設定
      # foreign_key: trueは必ずreference型をとる
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
