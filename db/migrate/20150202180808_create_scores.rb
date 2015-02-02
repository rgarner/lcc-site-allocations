class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :shlaa_ref
      t.string :score

      t.references :site
      t.references :score_type
    end

    add_index :scores, :shlaa_ref
    add_index :scores, [:site_id, :score_type_id], unique: true
  end
end
