require 'rails_helper'

RSpec.feature 'Blog setup', type: :feature do
  before do
    load Rails.root.join('db', 'seeds.rb')
  end

  scenario 'User accesses blog for the first time' do
    # Go to the blog setup
    visit '/'
    expect(page).to have_text I18n.t!('setup.index.welcome_to_your_blog_setup')

    # Set up the blog
    fill_in :setting_blog_name, with: 'Awesome blog'
    fill_in :setting_email, with: 'foo@bar.com'
    click_button I18n.t!('generic.save')

    # Confirm set up success
    expect(page).to have_text I18n.t!('accounts.confirm.success')

    # Visit the autogenerated article
    click_link I18n.t!('accounts.confirm.admin')
    click_link I18n.t!('admin.shared.menu.all_articles')
    find('tbody#articleList td a.published').click

    expect(page).to have_text I18n.t!('setup.article.title')

    # Confirm proper setting fo user properties
    expect(User.first.email).to eq 'foo@bar.com'
  end
end