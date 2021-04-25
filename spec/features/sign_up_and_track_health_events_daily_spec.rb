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
        page.find("p.alert").text
      end.to eq "You need to sign in or sign up before continuing."
    end

    When "Whitney attempts to signs in" do
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she needs to confirm her email before continuing" do
      wait_for do
        page.find("p.alert").text
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
        page.find("p.notice").text
      end.to eq "Your email address has been successfully confirmed."
    end

    When "she signs in again" do
      page.find("form.new_user").fill_in("Email", with: "whitney.wolfe@bumble.com")
      page.find("form.new_user").fill_in("Password", with: "1password")
      page.find("form.new_user").find('input[type="submit"]').click
    end

    Then "she sees a notification that she has signed in successfully" do
      wait_for do
        page.find("p.notice").text
      end.to eq "Signed in successfully."
    end

    When "Whitney chooses to add some health stats for today" do
      pending "no way to add stats for today"
      page.click_on("add stats for today")
    end

    Then "she sees today is 20th April 2021 and she can add stats"
    # need to lock time
    # add a stat

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
end
