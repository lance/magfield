User.find(:all).each do |user|
  user.plugins.create(:name => "News", :position => (user.plugins.maximum(:position) || -1) + 1)
end

page = Page.create(:title => "News",
            :link_url => "/news",
            :menu_match => "^/news.*$",
            :deletable => false,
            :position => Page.count)

RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end
