class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.references :voteable, polymorphic: true

      # same as t.references.....
      # t.integer :voteable_id
      # t.integer :voteable_type
      t.timestamps
    end
  end
end
