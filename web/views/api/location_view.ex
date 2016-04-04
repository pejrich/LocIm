defmodule LocIm.Api.LocationView do
  use LocIm.Web, :view

  def render("index.json", _) do
    %{
      posts: [
        %{
          id: 2,
          user: %{
            name: "Peter",
            id: 1,
            profile_picture_url: "https://www.drupal.org/files/profile_default.png"
          },
          image_url: "http://www.shaozhionthenet.com/wp-content/gallery/saigon-opera-house-ho-chi-minh-city-vietnam-july-2014/P7110003.jpg",
          longitude: 106.7009907,
          latitude: 10.7765229,
          created_at: 1459762063,
          category: "sight",
          reaction: false
        },

        %{
          id: 1,
          user: %{
            name: "Peter",
            id: 1,
            profile_picture_url: "https://www.drupal.org/files/profile_default.png"
          },
          image_url: "http://www.deluxegrouptours.vn/wp-content/uploads/2015/03/Notre-Dame-Cathedral-ho-chi-minh-city-tour-half-day4.jpg",
          longitude: 106.6989948,
          latitude: 10.7797838,
          created_at: 1459762009,
          category: "sight",
          reaction: true
        },

        %{
          id: 3,
          user: %{
            name: "Peter",
            id: 1,
            profile_picture_url: "https://www.drupal.org/files/profile_default.png"
          },
          image_url: "http://migrationology.com/wp-content/uploads/2014/12/best_banh_mi_saigon_vietnam-1024x682.jpg",
          longitude: 106.691721,
          latitude: 10.770791,
          created_at: 1459762127,
          category: "food",
          reaction: true
        }
      ]
    }
  end
end