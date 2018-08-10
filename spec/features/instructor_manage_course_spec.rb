require 'spec_helper'
feature 'Instructor can' do
  let(:administrator) { create(:administrator) }
  let(:instructor) { create(:instructor) }
  before do
    @course = create(:course)
    @categories = create_list(:category, 10)
  end

  scenario 'view courses', :js do
    sign_in_with instructor.user.username, instructor.user.password

    visit '/instructor/managecourses'
    expect(page).to have_content('Manage Courses')
  end

  scenario 'add course with any category name', :js do
    sign_in_with instructor.user.username, instructor.user.password
    visit '/instructor/managecourses'
    click_on 'Add New Course'
    fill_in :course_name, with: 'My New Course'
    page.execute_script('$("#course_description").val("Description of my course")')
    sleep 10
    # fill_in :action_type, with: 'Add', visible: false
    within '#course_category' do
      find("option[value='1']").click
    end
    within '#course_level' do
      find("option[value='2']").click
    end
    within '#course_days' do
      find("option[value='4']").click
    end
    check 'is_active'
    click_on 'Add'
    expect(current_path).to eq('/instructor/managecourses')
    # expect(page.body).to have_content('My New Course')
  end

  scenario 'view exising category', :js do
    sign_in_with instructor.user.username, instructor.user.password
    visit "/user/courses/view/#{@course.id}"
    expect(page.body).to have_content(@course.name)
  end

  scenario 'edit category with any category name', :js do
    sign_in_with instructor.user.username, instructor.user.password
    visit "/instructor/managecourses/#{@course.id}"
    fill_in :course_name, with: 'My Course Edited'
    check 'is_active'
    click_on 'Edit'
    # find_button('Add').click
    expect(current_path).to eq('/instructor/managecourses')
    expect(page.body).to have_content('My Course Edited')
  end
end
