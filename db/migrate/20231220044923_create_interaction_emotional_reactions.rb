class CreateInteractionEmotionalReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :interaction_emotional_reactions do |t|
      t.references :emotional_reaction, null: false, foreign_key: true
      t.references :interaction, null: false, foreign_key: true
      t.timestamps
    end

    add_index :interaction_emotional_reactions, [:emotional_reaction_id, :interaction_id],
      unique: true,
      name: 'index_interact_emotional_react_on_emotion_and_interact'
  end
end


