class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :name
			t.date :created_at
			t.string :from_user
			t.integer :from_user_id
			t.integer :from_user_id_str
			t.string :from_user_name
			t.language :iso_language_code
			t.string :profile_image_url
			t.string :text
      t.timestamps
    end
  end
end
