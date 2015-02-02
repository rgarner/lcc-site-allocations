class CreateScoreTypes < ActiveRecord::Migration
  def change
    create_table :score_types do |t|
      t.string :sa_objective_code
      t.string :description
      t.string :assumptions

      t.text   :scoring_descriptions
    end

    add_index :score_types, :sa_objective_code, unique: true
  end
end
