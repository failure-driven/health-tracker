class CreateDailyStats < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_stats, id: :uuid do |t|
      t.date :date, null: false
      t.jsonb :data
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index(:daily_stats, [:user_id, :date], unique: true)
  end
end
