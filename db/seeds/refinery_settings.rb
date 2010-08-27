[
  {:name => "show_social_media", :value => "true"},
  {:name => "facebook_page", :value => "magneticfield"},
  {:name => "twitter", :value => "themagneticfield"},
  {:name => "site_name", :value => "The Magnetic Field"},
  {:name => "new_page_parts", :value => false},
  {:name => "activity_show_limit", :value => 7},
  {:name => "preferred_image_view", :value => :grid},
  {:name => "analytics_page_code", :value => "UA-xxxxxx-x"},
  {:name => "theme", :value => "magneticfield"},
  {:name => "image_thumbnails", :value => {
    :dialog_thumb => 'c106x106',
    :grid => 'c135x135',
    :small => '110x110>',
    :medium => '225x255>',
    :large => '450x450>',
    :preview => 'c96x96'
    }
  }
].each do |setting|
  RefinerySetting.create(:name => setting[:name].to_s, :value => setting[:value], :destroyable => false)
end
