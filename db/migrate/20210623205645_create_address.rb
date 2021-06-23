class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.text :street
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
