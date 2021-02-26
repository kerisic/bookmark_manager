feature 'Filter bookmarks by tags' do
  scenario 'User can click on a tag and view all bookmarks that have that tag' do
    Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')
    Bookmark.add_bookmark(title: 'Sushi', url: 'http://www.sushi.com')
    Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')

    visit '/bookmarks'

    within page.find('.bookmark:nth-of-type(1)') do
      click_button 'Add Tag'
    end

    fill_in 'tag', with: 'Testing'
    click_button 'Submit'

    within page.find('.bookmark:nth-of-type(2)') do
      click_button 'Add Tag'
    end

    fill_in 'tag', with: 'Testing'
    click_button 'Submit'

    first('.bookmark').click_link 'Testing'

    expect(page).to have_link 'Makers', href: "http://www.makersacademy.com"
    expect(page).to have_link 'Sushi', href: "http://www.sushi.com"
    expect(page).not_to have_link 'Cheese', href: "http://www.cheese.com"
  end
end
