class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      # NOT NULL制約
      t.index :name, unique: true
      # 一意性制約
      t.timestamps
    end
  end
end
