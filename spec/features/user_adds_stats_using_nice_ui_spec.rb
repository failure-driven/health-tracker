require "rails_helper"

feature "User adds stats using nice UI", js: true do
  context "when a user existst with stats" do
    before do
      @user_claudia = create(:user_claudia)
      @user_claudia
        .daily_stats
        .append(
          create(
            :daily_stat,
            date: Date.parse("2015-04-01"),
            data: {situps: 100, weight: 66.6},
            user: @user_claudia,
          ),
        )
      @user_claudia
        .daily_stats
        .append(
          create(
            :daily_stat,
            date: Date.parse("2015-04-02"),
            data: {situps: 80, weight: 66.6},
            user: @user_claudia,
          ),
        )
    end

    scenario "Claudia signs in, sees her stats and updates them" do
      When "Claudia signs in and views her stats in admin" do
        visit root_path
        page.find("nav a", text: "Log in").click
        focus_on(:form).for(user_session_path).submit(
          "Email" => "claudia.king@automio.com",
          "Password" => "1password",
        )
        # expect(
        #   page.find("p.alert [data-testid=\"message\"]").text
        # ).to eq "Signed in successfully."
        page.find("nav a", text: "admin").click
        page.find("nav.navigation a", text: "Daily Stats").click
      end

      Then "she sees her stats for April 1 and 2" do
        expect(
          page
            .find_all("table tr td")
            .filter { |td| td["class"] =~ /(--date|--jsonb)/ }
            .map(&:text),
        ).to eq([
          "2015-04-01", "{ \"situps\": 100, \"weight\": 66.6 }",
          "2015-04-02", "{ \"situps\": 80, \"weight\": 66.6 }",
        ])
      end

      When "she uses the slick UI to add another stat" do
        page.find("nav a", text: "Back to app").click
        page.find("button", text: "add stats for today").click
        page.find("input[name=activity]").send_keys("chinups")
        page.find("input[name=answer]").send_keys("20")
        page.all("button", text: "Add")[0].click
        page.find("button", text: "Add this to my list").click
      end

      Then "she sees the new stat visible as well" do
        page.find("nav a", text: "admin").click
        page.find("nav.navigation a", text: "Daily Stats").click
        expect(
          page
            .find_all("table tr td")
            .filter { |td| td["class"] =~ /(--date|--jsonb)/ }
            .map(&:text),
        ).to match([
          "2015-04-01", "{ \"situps\": 100, \"weight\": 66.6 }",
          "2015-04-02", "{ \"situps\": 80, \"weight\": 66.6 }",
          match(/.*/), "{ \"chinups\": 20 }",
        ])
      end
    end
  end
end
