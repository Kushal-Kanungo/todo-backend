class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :description
      t.string :priority
      t.string :status
      t.timestamp :completion_date

      t.timestamps
    end
  end
end
