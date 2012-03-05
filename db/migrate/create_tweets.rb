class CreateTweets < ActiveRecord::Migration
  def self.up
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

	def self.down
		drop_table :tweets
	end
end
