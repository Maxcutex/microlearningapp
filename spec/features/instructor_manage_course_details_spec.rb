require 'spec_helper'
feature 'Instructor can' do
  let(:administrator) { create(:administrator) }
  let(:instructor) { create(:instructor) }
  before do
    @course = create(:course)
    @categories = create_list(:category, 10)
    @course_detail = create(:course_detail, course: @course)
  end

  scenario 'view courses details' do
    sign_in_with instructor.user.username, instructor.user.password

    visit "/user/coursedetail/#{@course_detail.id}"
    expect(page).to have_content('Manage Courses')
  end

  scenario 'add course details to a course' do
    sign_in_with instructor.user.username, instructor.user.password
    visit "/instructor/coursedetail/#{@course.id}/add"
    last_id = CourseDetail.get_last(@course.id)
    next_id = last_id.id + 1
    fill_in :day_topic, with: 'My New Topic'
    fill_in :day_details, with: '<p>In this topic we will talk about a lot of things</p>'

    # fill_in :action_type, with: 'Add', visible: false
    within '#day_num' do
      find("option[value='#{next_id}']").click
    end
    attach_file('Image Upload', 'spec/uploads/him.jpg')
    click_on 'Add'
    expect(current_path).to eq("/user/courses/view/#{@course.id}")
    # expect(page.body).to have_content('My New Course')
  end

  scenario 'view exising course detail' do
    sign_in_with instructor.user.username, instructor.user.password
    visit "/user/courses/view/#{@course.id}"
    expect(page.body).to have_content(@course.name)
  end

  scenario 'edit course detail with any category name', :js do
    sign_in_with instructor.user.username, instructor.user.password
    visit "/instructor/coursedetail/#{@course.id}/edit/#{@course_detail.id}"
    fill_in :day_topic, with: 'My Edited Topic'
    fill_in :day_details, with: '<p>Edited this topic we will talk about a lot of things</p>'

    within '#day_num' do
      find("option[value='#{@course_detail.id}']").click
    end
    # attach_file('Image Upload', 'spec/uploads/him.jpg') 
    click_on 'Edit'
    expect(current_path).to eq("/user/courses/view/#{@course.id}")
  end
end
