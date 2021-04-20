require "rails_helper"

feature "It works", js: true do
  scenario "I have rails" do
    When "user visits the app" do
      visit test_root_rails_path
    end

    Then "user sees they are on rails" do
      wait_for { focus_on(:welcome).message_and_versions }.to include(
        message: "Yay! You’re on Rails!",
        rails_version: match(/^6.1.3.1/),
        ruby_version: match(/^ruby 3.0.0/),
      )
    end
  end
end
