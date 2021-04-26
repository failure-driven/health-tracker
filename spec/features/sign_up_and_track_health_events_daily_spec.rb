require "rails_helper"

feature "Sign up and track health events daily", js: true do
  scenario "sign up and track health events" do
    When "Whitney Wolve of bumble visits health-tracker and signs up" do
      visit root_path
      page.within("main") do
        page.click_on("Sign up")
      end
    end

    And "she registers" do
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").fill_in("Password confirmation", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she needs to sign up before continuing" do
      wait_for do
        page.find("p.alert [data-testid=\"message\"]").text
      end.to eq "You need to sign in or sign up before continuing."
    end

    When "Whitney attempts to signs in" do
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she needs to confirm her email before continuing" do
      wait_for do
        page.find("p.alert [data-testid=\"message\"]").text
      end.to eq "You have to confirm your email address before continuing."
    end

    When "Whitney checks her email and confirms the email" do
      open_email "whitney.wolfe@bumble.com"
      wait_for do
        current_email.text
      end.to match(/Welcome whitney.wolfe@bumble.com!.*confirm.*link below: Confirm my account.*/)
      current_email.click_link "Confirm my account"
      clear_emails
    end

    Then "she sees a notification that she has successfully confirmed her email" do
      wait_for do
        page.find("p.alert-notice [data-testid=\"message\"]").text
      end.to eq "Your email address has been successfully confirmed."
    end

    When "she signs in again" do
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she has signed in successfully" do
      wait_for do
        page.find("p.alert-notice [data-testid=\"message\"]").text
      end.to eq "Signed in successfully."
    end

    When "Whitney chooses to add some health stats for today" do
      pending "no way to add stats for today"
      page.click_on("add stats for today")
    end

    Then "she sees today is 20th April 2021 and she can add stats" do
      # need to lock time
      # add a stat
    end

    When "Whitney adds her weight and push up count"
    # click add
    # name: weight
    # value: 55kg
    # click add
    # name: pushup count
    # value: 20
    # name: pushup type
    # value: 4 sets of 5
    # name: notes
    # value: feeling good today

    Then "they are added successfully"
    When "A day passes"
    And "She goes to add some health stats for today"
    And "She clicks add"
    Then "she sees she has an option to add any stat from previous days: "\
          "[weight, pushup count, pushup type, notes]"
    When "she adds more pushups"
    Then "she is shown she her pushups, and a trend line"
    And "she is also asked to confirm her previous day"
    When "she adds some pushups for the previous day and confirms"
    Then "she no longer can edit the previous day"
    But "she can still edit her current day"
    When "she also uploads a photo"
    Then "she is informed the photo will be used to train an AI to work out how healthy she is looking"
  end

  context "2 users exist and they use the admin interface to enter data" do
    before do
      @user_claudia = User.create!(
        email: "claudia.king@automio.com",
        password: "1password",
      )
      @user_claudia.confirm
      @user_claudia.daily_stats.create!(
        date: Date.parse("2015-04-01"),
        data: { notes: "founded a company",
                situps: 100, },
      )
      @user_claudia.daily_stats.create!(
        date: Date.parse("2015-04-02"),
        data: {
          notes: "day 2 of company",
          situps: 120,
        },
      )
      @user_ilana = User.create!(
        email: "ilana.feain@nano-x.com",
        password: "1password",
      )
      @user_ilana.confirm
    end

    scenario "users can only see themselves and edit their daily stats in the admin interface" do
      When "Claudia logs in and views admin" do
        visit root_path
        page.find("form.new_user").fill_in("Email", with: "claudia.king@automio.com")
        page.find("form.new_user").fill_in("Password", with: "1password")
        page.find("form.new_user").find('input[type="submit"]').click
        page.find("nav a", text: "admin").click
      end

      Then "she can only view herself as a user" do
        # TODO: move to page fragment
        headers = page.find_all("table thead tr th").map(&:text)
        fields_per_row = page
                         .find_all("table tbody tr")
                         .map do |row|
          headers.zip(row.find_all("td").map(&:text)).to_h
        end
        expect(
          fields_per_row.map { |row| row["Email"] },
        ).to eq(["claudia.king@automio.com"])
      end

      And "she can see her daily stats" do
        page.find(".navigation a", text: "Daily Stats").click
        # TODO: move to page fragment
        headers = page.find_all("table thead tr th").map(&:text)
        fields_per_row = page
                         .find_all("table tbody tr")
                         .map do |row|
          headers.zip(row.find_all("td").map(&:text)).to_h
        end
        expect(
          fields_per_row.map { |row| row["Date"] },
        ).to eq(%w[2015-04-01 2015-04-02])
      end

      When "she changes her daily stats for 2nd of April" do
        page
          .find_all("table tbody tr")
          .find { |row| row.text =~ /2015-04-02/ }
          .click
        page.find("header a", text: "Edit DailyStat").click
        # TODO: would not really change the date but more the json data
        page.find("form").fill_in("Date", with: "2015-04-10")
        page
          .find_all("form .field-unit")
          .find { |field| !field.find_all("label", text: "Date", wait: false).empty? }
          .find("input")
          .send_keys(:return)
        page.click_on("Update Daily stat")
      end

      Then "they change" do
        # TODO: simplify in page fragment
        keys = page
               .find("section.main-content__body")
               .find_all("dt")
               .map(&:text)
        values = page
                 .find("section.main-content__body")
                 .find_all("dd")
                 .map(&:text)
        wait_for do
          keys.zip(values).to_h
        end.to match(hash_including(
                       "USER" => "User #claudia.king@automio.com",
                       "DATE" => "2015-04-10",
                       "DATA" => "object\n{2}\nnotes\n:\nday 2 of company\nsitups\n:\n120",
                     ))
      end

      When "she navigates back to the app and logs out" do
        page.find(".navigation a", text: "Back to app").click
        page.find("nav a", text: "Sign out").click
      end

      Then "she is no longer logged in" do
        wait_for do
          page.find("p.alert [data-testid=\"message\"]").text
        end.to eq("You need to sign in or sign up before continuing.")
      end

      When "Ilana logs in and visits admin" do
        page.find("form.new_user").fill_in("Email", with: "ilana.feain@nano-x.com")
        page.find("form.new_user").fill_in("Password", with: "1password")
        page.find("form.new_user").find('input[type="submit"]').click
        page.find("nav a", text: "admin").click
      end

      Then "she can only view herself as a user" do
        # TODO: move to page fragment
        headers = page.find_all("table thead tr th").map(&:text)
        fields_per_row = page
                         .find_all("table tbody tr")
                         .map do |row|
          headers.zip(row.find_all("td").map(&:text)).to_h
        end
        expect(
          fields_per_row.map { |row| row["Email"] },
        ).to eq(["ilana.feain@nano-x.com"])
      end

      And "she has no daily stats" do
        page.find(".navigation a", text: "Daily Stats").click
        # TODO: move to page fragment
        headers = page.find_all("table thead tr th").map(&:text)
        fields_per_row = page
                         .find_all("table tbody tr")
                         .map do |row|
          headers.zip(row.find_all("td").map(&:text)).to_h
        end
        expect(
          fields_per_row.map { |row| row["Date"] },
        ).to be_empty
      end

      When "she adds daily stats"
      Then "she sees they have been created"
    end
  end
end
