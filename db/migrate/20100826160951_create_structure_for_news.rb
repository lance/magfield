class CreateStructureForNews < ActiveRecord::Migration

  def self.up
    create_table :news_items do |t|
      t.string :title
      t.text :body
      t.datetime :publish_date
      t.timestamps
    end

    add_index :news_items, :id
    load(Rails.root.join('db', 'seeds', 'news.rb'))

  end

  def self.down
    UserPlugin.destroy_all({:title => "News"})

    Page.find_all_by_link_url("/news").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/news"})

    drop_table :news_items
  end

end